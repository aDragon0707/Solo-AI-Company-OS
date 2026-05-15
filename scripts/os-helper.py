#!/usr/bin/env python3
"""Cross-platform Markdown helpers for Solo-AI-Company-OS.

No external dependencies. This mirrors the small PowerShell helpers for
macOS/Linux users and adds a privacy guard for public-facing text.
"""

from __future__ import annotations

import argparse
import datetime as dt
import hashlib
import math
import re
import sys
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]


def slugify(value: str, fallback: str) -> str:
    slug = re.sub(r"[^a-z0-9]+", "-", value.lower()).strip("-")
    return slug or fallback


def now_iso() -> str:
    return dt.datetime.now().astimezone().isoformat(timespec="seconds")


def write_new(path: Path, content: str) -> Path:
    path.parent.mkdir(parents=True, exist_ok=True)
    if path.exists():
        raise SystemExit(f"Refusing to overwrite existing file: {path}")
    path.write_text(content, encoding="utf-8")
    return path


def new_worklog(args: argparse.Namespace) -> None:
    output_dir = Path(args.output_dir)
    if not output_dir.is_absolute():
        output_dir = REPO_ROOT / output_dir

    date = dt.datetime.now().strftime("%Y%m%d")
    slug = slugify(args.title, "task")
    file_name = f"worklog_{date}_{args.agent_id}_{slug}.md"
    worklog_id = f"worklog_{date}_{args.agent_id}_{slug}"
    content = f"""---
type: worklog
protocol: SACP/0.1
id: {worklog_id}
agent_id: {args.agent_id}
status: draft
created_at: {now_iso()}
verification: pending
evolution_decision: record
---

# Worklog - {args.title}

## Task

- TODO: What was requested?

## Tools Used

- TODO: List tools, commands, scripts, or documents used.

## Work Completed

- TODO: What changed?

## Authority Packet

Current goal:

Authoritative files:

Do not read:

Max files to read:

Acceptance criteria:

Stop condition:

Allowed actions:

Forbidden actions:

Verification plan:

## State Confidence

Verified now:

Trusted snapshot:

Stale log:

Model inference:

Unknown:

## Worklog Brief

What happened:

Evidence kept:

Evidence discarded:

Current blocker:

Next reviewer action:

## Verification

- TODO: How was this checked?

## Residual Risk

- TODO: What remains uncertain?

## Evolution

Decision: ignore | record | distill | promote_candidate

Reason:

## Handoff

Next owner:

Next action:
"""
    print(write_new(output_dir / file_name, content))


def new_handoff(args: argparse.Namespace) -> None:
    output_dir = Path(args.output_dir)
    if not output_dir.is_absolute():
        output_dir = REPO_ROOT / output_dir

    date = dt.datetime.now().strftime("%Y%m%d")
    slug = slugify(args.task_title, "handoff")
    handoff_id = f"handoff_{date}_{slug}"
    lease_expires = (
        dt.datetime.now().astimezone() + dt.timedelta(minutes=args.lease_minutes)
    ).isoformat(timespec="seconds")
    source_fingerprint = args.source_fingerprint
    if source_fingerprint == "auto":
        source_fingerprint = "sha256:" + hashlib.sha256(
            args.task_title.encode("utf-8")
        ).hexdigest()[:16]

    content = f"""---
type: handoff
protocol: SACP/0.1
handoff_id: {handoff_id}
from_agent: {args.from_agent}
to_agent: {args.to_agent}
status: requested
attempt_id: attempt_001
lease_owner:
lease_expires_at: {lease_expires}
source_fingerprint: {source_fingerprint}
created_at: {now_iso()}
---

# Handoff - {args.task_title}

## Context

- TODO: What happened before this handoff?

## Requested Next Action

- TODO: What should {args.to_agent} do?

## Evidence / Inputs

- TODO: Link worklog, dashboard, artifact, or source note.

## Authority Packet

Current goal:

Authoritative files:

Do not read:

Max files to read: 5

Acceptance criteria:

Stop condition:

Allowed actions:

Forbidden actions:

Verification plan:

## State Confidence

Verified now:

Trusted snapshot:

Stale log:

Model inference:

Unknown:

## Worker Brief

What happened:

Evidence kept:

Evidence discarded:

Current blocker:

Recommended next action:

## Success Criteria

- TODO: How should the receiver know it is done?

## Retry Rule

Same handoff_id + same source_fingerprint + expired lease -> retry with new attempt_id.

Same handoff_id + new source_fingerprint -> rework/update, not duplicate.

New human decision or changed task identity -> create new handoff_id.
"""
    print(write_new(output_dir / f"{handoff_id}.md", content))


EXAMPLES = {
    "handoff-completed": """handoff_id: demo_001
status: completed
attempt_id: attempt_001
source_fingerprint: sha256:abc123
""",
    "handoff-active": """handoff_id: demo_002
status: processing
lease_owner: agent_a
lease_expires_at: 2099-01-01T10:00:00
attempt_id: attempt_001
source_fingerprint: sha256:abc123
""",
    "handoff-expired": """handoff_id: demo_003
status: processing
lease_owner: agent_a
lease_expires_at: 2020-01-01T10:00:00
attempt_id: attempt_001
source_fingerprint: sha256:abc123
""",
    "worklog-dirty": """owner: AI-02
findings:
  - response time is much faster
tools_used: []
verification:
evolution_decision: record
""",
    "privacy-rewrite": """I verified this in [PRIVATE_PROJECT_NAME] under [PRIVATE_LOCAL_PATH] with [PRIVATE_CUSTOMER_DATA].
""",
}


def doctor_example(args: argparse.Namespace) -> None:
    print(EXAMPLES[args.case], end="")


PRIVACY_PATTERNS = [
    ("windows_path", re.compile(r"\b[A-Za-z]:\\[^\s\]\)\"']+")),
    ("home_or_system_path", re.compile(r"(?<!\w)/(?:Users|home|var|mnt|private|tmp)/[^\s\]\)\"']+")),
    ("credential_assignment", re.compile(r"(?i)\b(?:api[_-]?key|secret|token|password|credential)\s*[:=]\s*[^\s]+")),
    ("openai_style_key", re.compile(r"\bsk-[A-Za-z0-9_-]{16,}\b")),
]


CONTEXT_WINDOWS = {
    "codex": 258_000,
    "longju": 131_000,
}

CJK_PATTERN = re.compile(
    r"[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff\uac00-\ud7af]"
)
WORD_PATTERN = re.compile(r"[A-Za-z0-9_]+")


def privacy_guard(args: argparse.Namespace) -> None:
    if args.file:
        text = Path(args.file).read_text(encoding="utf-8", errors="replace")
    elif args.text is not None:
        text = args.text
    else:
        text = sys.stdin.read()

    findings: list[tuple[str, str]] = []
    for name, pattern in PRIVACY_PATTERNS:
        for match in pattern.finditer(text):
            findings.append((name, match.group(0)))

    if not findings:
        print("privacy_guard: pass")
        return

    print("privacy_guard: blocked")
    for name, value in findings:
        print(f"- {name}: {value}")
    raise SystemExit(2)


def estimate_tokens(text: str) -> int:
    """Return a conservative no-dependency token estimate for mixed EN/ZH text."""
    if not text:
        return 0

    cjk_count = len(CJK_PATTERN.findall(text))
    without_cjk = CJK_PATTERN.sub(" ", text)
    word_tokens = sum(max(1, math.ceil(len(word) / 4)) for word in WORD_PATTERN.findall(without_cjk))
    symbol_count = len(re.sub(r"[A-Za-z0-9_\s]", "", without_cjk))
    newline_bonus = text.count("\n") // 4
    return max(1, math.ceil((cjk_count * 1.2) + word_tokens + (symbol_count * 0.5) + newline_bonus))


def context_phase(percent: float) -> tuple[str, str]:
    if percent >= 80:
        return ("new_window", "Do not continue long work; start a new window.")
    if percent >= 70:
        return ("stop_expansion", "Stop expansion; only finish, verify, or hand off.")
    if percent >= 60:
        return ("compress_state", "Write a compact state snapshot before continuing.")
    if percent >= 45:
        return ("converge", "Start converging; reduce new file reads.")
    return ("normal", "Normal execution; keep reads scoped.")


def context_budget(args: argparse.Namespace) -> None:
    window_tokens = args.window_tokens or CONTEXT_WINDOWS[args.agent]
    sources: list[tuple[str, str]] = []

    for file_value in args.file or []:
        path = Path(file_value)
        text = path.read_text(encoding="utf-8", errors="replace")
        sources.append((str(path), text))

    for index, text_value in enumerate(args.text or [], start=1):
        sources.append((f"text_{index}", text_value))

    if args.stdin:
        sources.append(("stdin", sys.stdin.read()))

    if not sources:
        raise SystemExit("context-budget needs --file, --text, or --stdin")

    per_source: list[tuple[str, int, int]] = []
    total_tokens = 0
    total_chars = 0
    for label, text in sources:
        token_count = estimate_tokens(text)
        char_count = len(text)
        per_source.append((label, char_count, token_count))
        total_tokens += token_count
        total_chars += char_count

    percent = (total_tokens / window_tokens) * 100 if window_tokens else 0
    phase, recommendation = context_phase(percent)
    adjusted_tokens = args.actual_used if args.actual_used is not None else total_tokens
    adjusted_percent = (adjusted_tokens / window_tokens) * 100 if window_tokens else 0
    adjusted_phase, adjusted_recommendation = context_phase(adjusted_percent)
    calibration_factor = None
    hidden_overhead = None
    if args.actual_used is not None:
        calibration_factor = args.actual_used / total_tokens if total_tokens else 0
        hidden_overhead = args.actual_used - total_tokens

    print("context_budget:")
    print(f"  agent: {args.agent}")
    print(f"  window_tokens: {window_tokens}")
    print(f"  estimated_tokens: {total_tokens}")
    print(f"  estimated_chars: {total_chars}")
    print(f"  usage_percent: {percent:.2f}")
    print(f"  phase: {phase}")
    print(f"  recommendation: {recommendation}")
    if args.actual_used is not None:
        print("  calibration:")
        print(f"    actual_used_tokens: {args.actual_used}")
        print(f"    adjusted_usage_percent: {adjusted_percent:.2f}")
        print(f"    adjusted_phase: {adjusted_phase}")
        print(f"    adjusted_recommendation: {adjusted_recommendation}")
        print(f"    calibration_factor: {calibration_factor:.2f}")
        print(f"    hidden_or_history_overhead: {hidden_overhead}")
    print("  thresholds:")
    print(f"    converge_45: {math.floor(window_tokens * 0.45)}")
    print(f"    compress_60: {math.floor(window_tokens * 0.60)}")
    print(f"    stop_expand_70: {math.floor(window_tokens * 0.70)}")
    print(f"    new_window_80: {math.floor(window_tokens * 0.80)}")
    print("  note: estimate_only; real platform usage may include hidden/system/history tokens.")
    print("sources:")
    for label, char_count, token_count in per_source:
        print(f"  - label: {label}")
        print(f"    chars: {char_count}")
        print(f"    estimated_tokens: {token_count}")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="Solo-AI-Company-OS helpers")
    sub = parser.add_subparsers(dest="command", required=True)

    p = sub.add_parser("new-worklog", help="Create a draft worklog")
    p.add_argument("--agent-id", default="AI-01")
    p.add_argument("--title", default="untitled task")
    p.add_argument("--output-dir", default="03_Company/AI_Worklogs")
    p.set_defaults(func=new_worklog)

    p = sub.add_parser("new-handoff", help="Create a draft handoff")
    p.add_argument("--from-agent", default="AI-01")
    p.add_argument("--to-agent", default="AI-02")
    p.add_argument("--task-title", default="handoff task")
    p.add_argument("--output-dir", default="03_Company/AI_Worklogs")
    p.add_argument("--lease-minutes", type=int, default=30)
    p.add_argument("--source-fingerprint", default="auto")
    p.set_defaults(func=new_handoff)

    p = sub.add_parser("doctor-example", help="Print a Doctor demo input")
    p.add_argument("--case", choices=sorted(EXAMPLES), default="handoff-expired")
    p.set_defaults(func=doctor_example)

    p = sub.add_parser("privacy-guard", help="Block likely private paths or credentials")
    p.add_argument("--file")
    p.add_argument("--text")
    p.set_defaults(func=privacy_guard)

    p = sub.add_parser("context-budget", help="Estimate context-window usage for files or text")
    p.add_argument("--agent", choices=sorted(CONTEXT_WINDOWS), default="codex")
    p.add_argument("--window-tokens", type=int, help="Override the context window size")
    p.add_argument("--file", action="append", help="UTF-8 text/Markdown file to estimate")
    p.add_argument("--text", action="append", help="Inline text to estimate")
    p.add_argument("--stdin", action="store_true", help="Read text from stdin")
    p.add_argument("--actual-used", type=int, help="Human-reported current context tokens for calibration")
    p.set_defaults(func=context_budget)

    return parser


def main() -> None:
    parser = build_parser()
    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
