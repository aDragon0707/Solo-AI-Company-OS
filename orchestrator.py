#!/usr/bin/env python3
"""OpenClaw L8 orchestrator scaffold for Solo-AI-Company-OS.

This is the first executable layer above the repository's Markdown operating
memory. It deliberately starts with file-backed queues and explicit review gates
because the product needs auditability before it needs distributed complexity.

Future adapters can replace the AgentExecutor with LangGraph, CrewAI, AutoGen,
or a cloud worker pool without changing the task envelope and queue contract.
"""

from __future__ import annotations

import argparse
import dataclasses
import datetime as dt
import hashlib
import json
import os
import shutil
import sys
import uuid
from pathlib import Path
from typing import Any

from memory_manager import MemoryManager, MemoryRecord


REPO_ROOT = Path(__file__).resolve().parent
TASK_STATES = ("pending", "processing", "completed", "blocked", "failed")


def utc_now() -> str:
    return dt.datetime.now(dt.timezone.utc).isoformat(timespec="seconds")


def read_config(path: str | Path) -> dict[str, Any]:
    """Load config from JSON-compatible YAML or PyYAML when available."""

    text = Path(path).read_text(encoding="utf-8")
    try:
        return json.loads(text)
    except json.JSONDecodeError:
        pass

    try:
        import yaml  # type: ignore
    except ImportError as exc:
        raise SystemExit(
            "Config is not JSON-compatible and PyYAML is not installed. "
            "Use JSON-compatible YAML or install pyyaml."
        ) from exc
    return dict(yaml.safe_load(text))


def resolve_path(raw_path: str | Path) -> Path:
    path = Path(raw_path)
    return path if path.is_absolute() else REPO_ROOT / path


def task_fingerprint(text: str, metadata: dict[str, Any] | None = None) -> str:
    """Stable fingerprint used for idempotency and duplicate detection."""

    payload = {"text": text.strip(), "metadata": metadata or {}}
    encoded = json.dumps(payload, ensure_ascii=False, sort_keys=True)
    return "sha256:" + hashlib.sha256(encoded.encode("utf-8")).hexdigest()[:16]


@dataclasses.dataclass
class TaskEnvelope:
    """Machine-readable unit of work for every agent."""

    task_id: str
    task_text: str
    task_type: str
    assigned_agent: str
    priority: int
    status: str
    source: str
    source_fingerprint: str
    created_at: str
    updated_at: str
    context_memories: list[dict[str, Any]]
    review_required: list[str]
    metadata: dict[str, Any]
    result: dict[str, Any]

    @classmethod
    def create(
        cls,
        *,
        task_text: str,
        task_type: str,
        assigned_agent: str,
        priority: int,
        source: str,
        source_fingerprint: str,
        context_memories: list[dict[str, Any]],
        review_required: list[str],
        metadata: dict[str, Any] | None = None,
    ) -> "TaskEnvelope":
        now = utc_now()
        short_id = uuid.uuid4().hex[:10]
        return cls(
            task_id=f"task_{dt.datetime.now().strftime('%Y%m%d')}_{short_id}",
            task_text=task_text,
            task_type=task_type,
            assigned_agent=assigned_agent,
            priority=priority,
            status="pending",
            source=source,
            source_fingerprint=source_fingerprint,
            created_at=now,
            updated_at=now,
            context_memories=context_memories,
            review_required=review_required,
            metadata=dict(metadata or {}),
            result={},
        )

    def to_dict(self) -> dict[str, Any]:
        return dataclasses.asdict(self)

    @classmethod
    def from_file(cls, path: Path) -> "TaskEnvelope":
        return cls(**json.loads(path.read_text(encoding="utf-8")))


class EventLog:
    """Append-only event stream for task lifecycle observability."""

    def __init__(self, log_dir: Path) -> None:
        self.path = log_dir / "events.jsonl"
        self.path.parent.mkdir(parents=True, exist_ok=True)

    def append(self, event_type: str, payload: dict[str, Any]) -> None:
        event = {"time": utc_now(), "event_type": event_type, "payload": payload}
        with self.path.open("a", encoding="utf-8") as handle:
            handle.write(json.dumps(event, ensure_ascii=False, sort_keys=True) + "\n")


class FileTaskQueue:
    """Durable queue backed by one JSON file per task."""

    def __init__(self, queue_dir: Path, event_log: EventLog) -> None:
        self.queue_dir = queue_dir
        self.event_log = event_log
        for state in TASK_STATES:
            (self.queue_dir / state).mkdir(parents=True, exist_ok=True)

    def _path(self, status: str, task_id: str) -> Path:
        return self.queue_dir / status / f"{task_id}.json"

    def enqueue(self, task: TaskEnvelope) -> Path:
        path = self._path("pending", task.task_id)
        path.write_text(json.dumps(task.to_dict(), ensure_ascii=False, indent=2), encoding="utf-8")
        self.event_log.append("task_enqueued", {"task_id": task.task_id, "agent": task.assigned_agent})
        return path

    def find_duplicate(self, source_fingerprint: str) -> TaskEnvelope | None:
        for state in TASK_STATES:
            for path in (self.queue_dir / state).glob("*.json"):
                task = TaskEnvelope.from_file(path)
                if task.source_fingerprint == source_fingerprint:
                    return task
        return None

    def next_pending(self) -> TaskEnvelope | None:
        tasks = [TaskEnvelope.from_file(path) for path in (self.queue_dir / "pending").glob("*.json")]
        if not tasks:
            return None
        tasks.sort(key=lambda task: (-task.priority, task.created_at))
        return tasks[0]

    def transition(self, task: TaskEnvelope, new_status: str) -> Path:
        if new_status not in TASK_STATES:
            raise ValueError(f"Unsupported task status: {new_status}")

        old_path = self._path(task.status, task.task_id)
        task.status = new_status
        task.updated_at = utc_now()
        new_path = self._path(new_status, task.task_id)
        new_path.write_text(json.dumps(task.to_dict(), ensure_ascii=False, indent=2), encoding="utf-8")
        if old_path.exists() and old_path != new_path:
            old_path.unlink()
        self.event_log.append("task_transitioned", {"task_id": task.task_id, "status": new_status})
        return new_path


class Router:
    """Config-driven task router.

    This starts rule-based on purpose. LLM routing can be added later, but the
    deterministic route remains useful as a safety baseline and test oracle.
    """

    def __init__(self, config: dict[str, Any]) -> None:
        self.config = config
        self.rules = list(config.get("routing_rules", []))

    def route(self, task_text: str, explicit_agent: str | None = None) -> tuple[str, str]:
        if explicit_agent:
            return explicit_agent, "explicit"

        lowered = task_text.lower()
        for rule in self.rules:
            keywords = [str(keyword).lower() for keyword in rule.get("keywords", [])]
            if any(keyword in lowered for keyword in keywords):
                return str(rule["agent_id"]), str(rule.get("task_type", "routed"))

        return "AI-01", "triage"

    def review_gates_for(self, task_text: str, assigned_agent: str) -> list[str]:
        gates = self.config.get("review_gates", {})
        lowered = task_text.lower()
        required: list[str] = []

        public_markers = ("public", "publish", "customer", "sales", "landing", "公开", "客户", "发布", "销售")
        external_markers = ("send", "upload", "install", "pay", "contact", "发送", "上传", "安装", "付款", "联系")

        if gates.get("public_output_requires_ai04", True) and any(marker in lowered for marker in public_markers):
            if assigned_agent != "AI-04":
                required.append("AI-04 claim/privacy review")

        if gates.get("external_action_requires_human", True) and any(marker in lowered for marker in external_markers):
            required.append("human approval before external action")

        return required


class AgentExecutor:
    """Provider-neutral execution adapter.

    The scaffold returns a structured work packet instead of pretending to call
    an agent. Production deployments should implement `execute` with an LLM
    provider, a LangGraph graph, CrewAI crew, AutoGen swarm, or internal workers.
    """

    def __init__(self, config: dict[str, Any]) -> None:
        self.config = config

    def execute(self, task: TaskEnvelope) -> dict[str, Any]:
        agent = self.config.get("agents", {}).get(task.assigned_agent, {})
        return {
            "mode": "execution_stub",
            "assigned_agent": task.assigned_agent,
            "agent_name": agent.get("name", "Unknown Agent"),
            "task_type": task.task_type,
            "recommended_next_action": (
                "Connect this adapter to the selected LLM/agent framework. "
                "Use context_memories, role_path, and start_prompt_path as the "
                "execution prompt packet."
            ),
            "role_path": agent.get("role_path"),
            "start_prompt_path": agent.get("start_prompt_path"),
            "review_required": task.review_required,
        }


class OpenClawOrchestrator:
    """Main L8 runtime: intake, route, queue, execute, log, remember."""

    def __init__(self, config_path: str | Path = "config/client_vars.yaml") -> None:
        self.config_path = resolve_path(config_path)
        self.config = read_config(self.config_path)
        runtime = self.config.get("runtime", {})

        self.events = EventLog(resolve_path(runtime.get("log_dir", "runtime/logs")))
        self.queue = FileTaskQueue(resolve_path(runtime.get("queue_dir", "runtime/queues")), self.events)
        self.memory = MemoryManager(resolve_path(runtime.get("memory_store", "runtime/memory/memory.jsonl")))
        self.router = Router(self.config)
        self.executor = AgentExecutor(self.config)

    def submit(
        self,
        task_text: str,
        *,
        source: str = "cli",
        explicit_agent: str | None = None,
        priority: int | None = None,
        metadata: dict[str, Any] | None = None,
    ) -> TaskEnvelope:
        fingerprint = task_fingerprint(task_text, metadata)
        duplicate = self.queue.find_duplicate(fingerprint)
        if duplicate:
            self.events.append("task_duplicate_detected", {"task_id": duplicate.task_id})
            return duplicate

        assigned_agent, task_type = self.router.route(task_text, explicit_agent=explicit_agent)
        review_required = self.router.review_gates_for(task_text, assigned_agent)
        max_memories = int(self.config.get("runtime", {}).get("max_context_memories", 5))
        memories = [
            {"score": round(score, 4), "memory_id": record.memory_id, "text": record.text}
            for score, record in self.memory.search(task_text, top_k=max_memories)
        ]

        task = TaskEnvelope.create(
            task_text=task_text,
            task_type=task_type,
            assigned_agent=assigned_agent,
            priority=priority if priority is not None else int(self.config.get("runtime", {}).get("default_priority", 50)),
            source=source,
            source_fingerprint=fingerprint,
            context_memories=memories,
            review_required=review_required,
            metadata=metadata,
        )
        self.queue.enqueue(task)
        return task

    def run_once(self) -> TaskEnvelope | None:
        task = self.queue.next_pending()
        if task is None:
            self.events.append("queue_empty", {})
            return None

        self.queue.transition(task, "processing")
        try:
            task.result = self.executor.execute(task)
            final_status = "blocked" if any("human approval" in gate for gate in task.review_required) else "completed"
            self.queue.transition(task, final_status)
            self._persist_memory(task)
            return task
        except Exception as exc:
            task.result = {"error": repr(exc)}
            self.queue.transition(task, "failed")
            raise

    def _persist_memory(self, task: TaskEnvelope) -> None:
        namespace = self.config.get("memory", {}).get("default_namespace", "methodology")
        summary = (
            f"Task {task.task_id} routed to {task.assigned_agent} as {task.task_type}. "
            f"Status: {task.status}. Review gates: {', '.join(task.review_required) or 'none'}."
        )
        record = MemoryRecord.create(
            namespace=namespace,
            text=summary,
            source=task.task_id,
            tags=["task_route", task.assigned_agent, task.task_type],
            confidence="trusted_snapshot",
            metadata={"task_id": task.task_id, "status": task.status},
        )
        self.memory.add(record)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="OpenClaw L8 task orchestrator")
    parser.add_argument("--config", default="config/client_vars.yaml")

    subcommands = parser.add_subparsers(dest="command", required=True)

    submit_cmd = subcommands.add_parser("submit", help="submit a task to the queue")
    submit_cmd.add_argument("task_text")
    submit_cmd.add_argument("--agent")
    submit_cmd.add_argument("--priority", type=int)
    submit_cmd.add_argument("--source", default="cli")

    subcommands.add_parser("run-once", help="process one pending task")
    subcommands.add_parser("doctor", help="print runtime health")

    return parser


def print_json(payload: dict[str, Any]) -> None:
    print(json.dumps(payload, ensure_ascii=False, indent=2, sort_keys=True))


def main() -> None:
    args = build_parser().parse_args()
    orchestrator = OpenClawOrchestrator(args.config)

    if args.command == "submit":
        task = orchestrator.submit(
            args.task_text,
            explicit_agent=args.agent,
            priority=args.priority,
            source=args.source,
        )
        print_json(task.to_dict())
        return

    if args.command == "run-once":
        task = orchestrator.run_once()
        print_json({"status": "empty"} if task is None else task.to_dict())
        return

    if args.command == "doctor":
        runtime = orchestrator.config.get("runtime", {})
        queue_dir = resolve_path(runtime.get("queue_dir", "runtime/queues"))
        payload = {
            "config": str(orchestrator.config_path),
            "queue_dir": str(queue_dir),
            "memory_store": str(resolve_path(runtime.get("memory_store", "runtime/memory/memory.jsonl"))),
            "states": {
                state: len(list((queue_dir / state).glob("*.json")))
                for state in TASK_STATES
            },
            "python": sys.version.split()[0],
            "executor": "stub",
        }
        print_json(payload)
        return


if __name__ == "__main__":
    main()
