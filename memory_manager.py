#!/usr/bin/env python3
"""Long-term memory layer for the OpenClaw Solo-AI runtime.

The first commercial-grade version should be boring and auditable:

- append-only JSONL storage so every memory can be inspected in Git or a log
- deterministic local embeddings so the system works without network access
- clear swap points for hosted embeddings or a real vector database
- explicit confidence and namespace fields so memory does not become "truth soup"

This module is intentionally dependency-light. If PyYAML or a vector database is
added later, the public API below should stay stable.
"""

from __future__ import annotations

import argparse
import dataclasses
import datetime as dt
import hashlib
import json
import math
import re
from pathlib import Path
from typing import Any, Iterable


DEFAULT_DIMENSIONS = 256


def utc_now() -> str:
    """Return a stable ISO timestamp for machine logs."""

    return dt.datetime.now(dt.timezone.utc).isoformat(timespec="seconds")


def stable_id(prefix: str, text: str) -> str:
    """Create a deterministic ID from content for dedupe-friendly writes."""

    digest = hashlib.sha256(text.encode("utf-8")).hexdigest()[:16]
    return f"{prefix}_{digest}"


def tokenize(text: str) -> list[str]:
    """Tokenize English and CJK-ish text without external NLP dependencies."""

    lowered = text.lower()
    words = re.findall(r"[a-z0-9_]+|[\u4e00-\u9fff]", lowered)
    return words or [lowered[:64]]


def hash_embedding(text: str, dimensions: int = DEFAULT_DIMENSIONS) -> list[float]:
    """Build a deterministic local embedding.

    This is not a semantic model. It is a safe fallback that gives useful lexical
    retrieval for development, demos, and air-gapped client installs. Production
    deployments can replace this method with OpenAI, local BGE, pgvector, Qdrant,
    or another embedding backend.
    """

    vector = [0.0] * dimensions
    for token in tokenize(text):
        digest = hashlib.blake2b(token.encode("utf-8"), digest_size=8).digest()
        bucket = int.from_bytes(digest[:4], "big") % dimensions
        sign = 1.0 if digest[4] % 2 == 0 else -1.0
        vector[bucket] += sign

    norm = math.sqrt(sum(value * value for value in vector)) or 1.0
    return [value / norm for value in vector]


def cosine(left: list[float], right: list[float]) -> float:
    """Return cosine similarity for equal-length vectors."""

    if len(left) != len(right):
        raise ValueError("Embedding vectors must have equal dimensions.")
    return sum(a * b for a, b in zip(left, right))


@dataclasses.dataclass(frozen=True)
class MemoryRecord:
    """A single durable memory item.

    confidence is deliberately explicit:
    - verified_now: fresh tool/file/human evidence
    - trusted_snapshot: dashboard or reviewed worklog
    - model_inference: useful but not fact
    - unknown: retained only as a question or blocker
    """

    memory_id: str
    namespace: str
    text: str
    source: str
    tags: list[str]
    confidence: str
    created_at: str
    embedding: list[float]
    metadata: dict[str, Any]

    @classmethod
    def create(
        cls,
        *,
        namespace: str,
        text: str,
        source: str,
        tags: Iterable[str] | None = None,
        confidence: str = "trusted_snapshot",
        metadata: dict[str, Any] | None = None,
    ) -> "MemoryRecord":
        raw_id = f"{namespace}:{source}:{text}"
        return cls(
            memory_id=stable_id("mem", raw_id),
            namespace=namespace,
            text=text.strip(),
            source=source,
            tags=list(tags or []),
            confidence=confidence,
            created_at=utc_now(),
            embedding=hash_embedding(text),
            metadata=dict(metadata or {}),
        )

    def to_json(self) -> str:
        return json.dumps(dataclasses.asdict(self), ensure_ascii=False, sort_keys=True)

    @classmethod
    def from_dict(cls, payload: dict[str, Any]) -> "MemoryRecord":
        return cls(
            memory_id=str(payload["memory_id"]),
            namespace=str(payload["namespace"]),
            text=str(payload["text"]),
            source=str(payload["source"]),
            tags=list(payload.get("tags", [])),
            confidence=str(payload.get("confidence", "trusted_snapshot")),
            created_at=str(payload.get("created_at", utc_now())),
            embedding=[float(value) for value in payload.get("embedding", [])],
            metadata=dict(payload.get("metadata", {})),
        )


class MemoryManager:
    """Append-only memory store with retrieval and reflection helpers."""

    def __init__(self, store_path: str | Path) -> None:
        self.store_path = Path(store_path)
        self.store_path.parent.mkdir(parents=True, exist_ok=True)

    def add(self, record: MemoryRecord) -> MemoryRecord:
        """Append a memory unless the same memory_id already exists."""

        existing_ids = {item.memory_id for item in self.load_all()}
        if record.memory_id in existing_ids:
            return record
        with self.store_path.open("a", encoding="utf-8") as handle:
            handle.write(record.to_json() + "\n")
        return record

    def load_all(self) -> list[MemoryRecord]:
        """Load all valid memories. Corrupt lines fail loudly by design."""

        if not self.store_path.exists():
            return []
        records: list[MemoryRecord] = []
        for line in self.store_path.read_text(encoding="utf-8").splitlines():
            if line.strip():
                records.append(MemoryRecord.from_dict(json.loads(line)))
        return records

    def search(
        self,
        query: str,
        *,
        namespace: str | None = None,
        top_k: int = 5,
    ) -> list[tuple[float, MemoryRecord]]:
        """Return memories ranked by local vector similarity."""

        query_embedding = hash_embedding(query)
        candidates = self.load_all()
        if namespace:
            candidates = [item for item in candidates if item.namespace == namespace]

        ranked = [
            (cosine(query_embedding, item.embedding), item)
            for item in candidates
            if item.embedding
        ]
        ranked.sort(key=lambda item: item[0], reverse=True)
        return ranked[:top_k]

    def reflect_task_outcome(
        self,
        *,
        task_id: str,
        task_text: str,
        outcome: str,
        feedback: str,
        namespace: str = "failure_pattern",
    ) -> MemoryRecord:
        """Capture a reflection memory from task outcome and feedback.

        This does not auto-promote a skill. It only stores an auditable lesson
        candidate that a human or AI-04/AI-01 can later review.
        """

        lesson = (
            f"Task: {task_text}\n"
            f"Outcome: {outcome}\n"
            f"Feedback: {feedback}\n"
            "Reflection: preserve what worked, expose what failed, and require "
            "human approval before changing standing instructions."
        )
        record = MemoryRecord.create(
            namespace=namespace,
            text=lesson,
            source=task_id,
            tags=["reflection", "candidate"],
            confidence="trusted_snapshot",
            metadata={"task_id": task_id, "promotion_status": "candidate"},
        )
        return self.add(record)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="OpenClaw memory manager")
    parser.add_argument("--store", default="runtime/memory/memory.jsonl")

    subcommands = parser.add_subparsers(dest="command", required=True)

    add_cmd = subcommands.add_parser("add", help="append a memory")
    add_cmd.add_argument("text")
    add_cmd.add_argument("--namespace", default="methodology")
    add_cmd.add_argument("--source", default="manual")
    add_cmd.add_argument("--tag", action="append", default=[])
    add_cmd.add_argument("--confidence", default="trusted_snapshot")

    search_cmd = subcommands.add_parser("search", help="search memories")
    search_cmd.add_argument("query")
    search_cmd.add_argument("--namespace")
    search_cmd.add_argument("--top-k", type=int, default=5)

    return parser


def main() -> None:
    args = build_parser().parse_args()
    manager = MemoryManager(args.store)

    if args.command == "add":
        record = MemoryRecord.create(
            namespace=args.namespace,
            text=args.text,
            source=args.source,
            tags=args.tag,
            confidence=args.confidence,
        )
        print(manager.add(record).to_json())
        return

    if args.command == "search":
        for score, record in manager.search(
            args.query,
            namespace=args.namespace,
            top_k=args.top_k,
        ):
            print(json.dumps({"score": round(score, 4), **dataclasses.asdict(record)}, ensure_ascii=False))


if __name__ == "__main__":
    main()
