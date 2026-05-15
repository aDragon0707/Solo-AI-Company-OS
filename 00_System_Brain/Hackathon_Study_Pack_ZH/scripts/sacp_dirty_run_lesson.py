"""SACP/0.1 Dirty Run teaching script.

This is a small educational script, not a production parser, CLI, service,
database, or release validator.

It reads the hand-written fixtures in tests/fixtures/sacp_dirty_run and shows
how an agent can reason about handoff idempotency from Markdown + YAML
frontmatter.
"""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Any

import yaml


ROOT = Path(__file__).resolve().parents[3]
FIXTURE_DIR = ROOT / "tests" / "fixtures" / "sacp_dirty_run"
OUT_DIR = Path(__file__).resolve().parents[1] / "out"


@dataclass
class Entity:
    path: Path
    frontmatter: dict[str, Any]
    body: str

    @property
    def id(self) -> str:
        return str(self.frontmatter.get("id", self.path.stem))

    @property
    def type(self) -> str:
        return str(self.frontmatter.get("type", "unknown"))


def read_markdown_entity(path: Path) -> Entity:
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        return Entity(path=path, frontmatter={}, body=text)

    _, yaml_block, body = text.split("---", 2)
    frontmatter = yaml.safe_load(yaml_block) or {}
    return Entity(path=path, frontmatter=frontmatter, body=body.strip())


def load_entities() -> list[Entity]:
    return [read_markdown_entity(path) for path in sorted(FIXTURE_DIR.glob("*.md"))]


def find_receiving_worklogs(entities: list[Entity], handoff_id: str) -> list[Entity]:
    receiving = []
    for entity in entities:
        fm = entity.frontmatter
        processed = fm.get("processed_handoff_ids") or []
        if fm.get("source_handoff_id") == handoff_id or handoff_id in processed:
            receiving.append(entity)
    return receiving


def decide_handoff(source: Entity, entities: list[Entity]) -> dict[str, Any]:
    fm = source.frontmatter
    handoff_id = fm.get("handoff_id") or fm.get("id")
    receiving = find_receiving_worklogs(entities, str(handoff_id))

    result: dict[str, Any] = {
        "source_file": str(source.path.relative_to(ROOT)),
        "handoff_id": handoff_id,
        "next_owner": fm.get("downstream_handoff") or fm.get("to_agent") or fm.get("owner"),
        "source_status": fm.get("status"),
        "source_handoff_status": fm.get("handoff_status"),
        "receiving_worklogs": [str(item.path.relative_to(ROOT)) for item in receiving],
        "create_new_handoff": False,
        "repeat_trigger": False,
        "new_attempt_id": False,
        "verdict": "unknown",
        "reason": "",
    }

    if not receiving:
        result.update(
            {
                "create_new_handoff": False,
                "repeat_trigger": True,
                "verdict": "process_once",
                "reason": (
                    "No receiving worklog cites this handoff_id. The target owner may "
                    "process the request once, but repeated reads still must use the "
                    "same handoff_id."
                ),
            }
        )
        return result

    # Teaching simplification: use the first matching receiving worklog.
    receiver = receiving[0]
    receiver_status = str(receiver.frontmatter.get("status", "unknown"))
    result["receiving_status"] = receiver_status

    if receiver_status == "completed":
        result.update(
            {
                "verdict": "dedup_skip",
                "reason": (
                    "A receiving worklog cites source_handoff_id and is completed. "
                    "Do not create a new handoff and do not trigger the receiver again."
                ),
            }
        )
        return result

    if receiver_status == "processing":
        lease_expires_at = receiver.frontmatter.get("lease_expires_at")
        if lease_expires_at:
            result.update(
                {
                    "verdict": "wait_or_check_lease",
                    "reason": (
                        "Receiving worklog is processing. Check whether lease_expires_at "
                        "is still active before retrying."
                    ),
                }
            )
        else:
            result.update(
                {
                    "new_attempt_id": True,
                    "verdict": "retry_with_attempt_id",
                    "reason": (
                        "Receiving worklog is processing but has no visible lease. In a "
                        "dirty run, retry should keep handoff_id and create a new attempt_id."
                    ),
                }
            )
        return result

    if receiver_status in {"failed", "expired", "blocked"}:
        result.update(
            {
                "new_attempt_id": receiver_status != "blocked",
                "verdict": "retry_or_human",
                "reason": (
                    "Receiving worklog exists but is not complete. Retry keeps the same "
                    "handoff_id and increments attempt_id unless human decision or input changed."
                ),
            }
        )
        return result

    result.update(
        {
            "verdict": "review_required",
            "reason": "Receiving worklog exists but status is unknown. Human or reviewer should inspect it.",
        }
    )
    return result


def render_report(results: list[dict[str, Any]]) -> str:
    lines = [
        "# SACP Dirty Run Lesson Output",
        "",
        "This report is generated by a teaching script. It is not a production validator.",
        "",
    ]
    for result in results:
        lines.extend(
            [
                f"## Handoff: `{result['handoff_id']}`",
                "",
                f"- Source file: `{result['source_file']}`",
                f"- Next owner: `{result['next_owner']}`",
                f"- Source status: `{result['source_status']}`",
                f"- Source handoff_status: `{result['source_handoff_status']}`",
                f"- Receiving worklogs: {result['receiving_worklogs']}",
                f"- Create new handoff: `{result['create_new_handoff']}`",
                f"- Repeat trigger: `{result['repeat_trigger']}`",
                f"- New attempt_id: `{result['new_attempt_id']}`",
                f"- Verdict: `{result['verdict']}`",
                f"- Reason: {result['reason']}",
                "",
            ]
        )
    return "\n".join(lines)


def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    entities = load_entities()
    handoff_sources = [
        entity
        for entity in entities
        if entity.frontmatter.get("handoff_id") or entity.frontmatter.get("type") == "handoff"
    ]
    results = [decide_handoff(entity, entities) for entity in handoff_sources]
    report = render_report(results)
    output_path = OUT_DIR / "sacp_dirty_run_lesson_output.md"
    output_path.write_text(report, encoding="utf-8")
    print(report)
    print(f"\nWrote report: {output_path}")


if __name__ == "__main__":
    main()

