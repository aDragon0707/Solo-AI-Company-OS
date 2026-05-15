# L10 OpenClaw Agentic System Blueprint

## Phase 1 - Current Asset Map

Solo-AI-Company-OS is currently a Markdown-first operating memory system. Its strongest assets are not code; they are role boundaries, handoff discipline, worklogs, claim review rules, and skill distillation.

### Existing Agents

| Agent | Current Role | Productized Runtime Responsibility |
|---|---|---|
| AI-01 Founder Office / PMO | routing, priority, state sync | default task router and human-decision guard |
| AI-02 Builder / Evidence Owner | implementation, verification, evidence | builder, tester, artifact owner |
| AI-03 Growth / Revenue | public-facing copy, offers, revenue tasks | commercial deliverable producer |
| AI-04 Research / Risk | claim review, privacy, risk | review gate before external/customer-facing output |
| AI-05 Learning Tutor | explanation, founder learning | training, SOP, onboarding, knowledge transfer |

### Existing Skills

| Skill Cluster | Current Source | Runtime Use |
|---|---|---|
| Task Breakdown And Routing | `03_Company/Skills/SKILL_LIBRARY.md` | orchestrator routing policy |
| State Sync | `03_Company/Skills/SKILL_LIBRARY.md` | context refresh before execution |
| Handoff Writing | `03_Company/Skills/SKILL_LIBRARY.md` | queue handoff packet generation |
| Project Truth Check | `03_Company/Skills/SKILL_LIBRARY.md` | verification gate |
| Customer-Facing Draft | `03_Company/Skills/SKILL_LIBRARY.md` | sales/content deliverables |
| Claim Boundary Review | `03_Company/Skills/SKILL_LIBRARY.md` | risk review gate |
| Worklog To Skill Distillation | `03_Company/Skills/SKILL_LIBRARY.md` | capability upgrade loop |
| SACP Handoff Contract | `00_System_Brain/SACP_MINIMAL_SPEC.md` | idempotency and retry lifecycle |

## Phase 1 - L8 Gap Diagnosis

The system is close to a strong operating manual, but not yet a commercial-grade agentic runtime.

| Gap | Current State | Required Upgrade |
|---|---|---|
| Central router | AI-01 instructions exist, no executable router | `orchestrator.py` with rule-based routing and queue lifecycle |
| Queue | handoff Markdown exists, no runnable queue | file-backed task queue with status transitions |
| Idempotency | SACP spec defines handoff IDs | runtime fingerprinting and duplicate detection |
| Logging | worklog templates exist | machine-readable event log per task |
| Review gates | AI-04 rules exist | enforced risk/claim/privacy gates before completion |
| Memory | Markdown memory exists | searchable JSONL/vector memory with promotion rules |
| Client install | vault init exists | `config/client_vars.yaml` as portable client configuration |

## Phase 2 - L8 Orchestrator

Task flow:

```text
intake -> fingerprint -> route -> enqueue -> claim -> execute/stub -> review -> persist memory -> close
```

The first production layer should remain deterministic:

- task intake is JSON or CLI text
- routing comes from `config/client_vars.yaml`
- task state is stored under `runtime/queues`
- events are appended under `runtime/logs/events.jsonl`
- memory retrieval is read-only during planning and append-only after completion
- human approval blocks external actions, spending, publishing, installing, or contacting people

## Phase 2 - L9 Memory And Reflection

Memory should be separated into four namespaces:

| Namespace | Purpose | Promotion Rule |
|---|---|---|
| `client_profile` | client business context, constraints, vocabulary | human-approved only |
| `methodology` | reusable Solo-AI/OpenClaw operating methods | promote from repeated successful worklogs |
| `deliverable_pattern` | reusable outputs, templates, examples | promote after verification and review |
| `failure_pattern` | mistakes, blockers, false assumptions | promote after reflection |

Reflection loop:

```text
task outcome -> feedback -> classify lesson -> store memory -> propose skill update -> human approves -> config/prompt changes
```

The system must not silently rewrite its own rules. It may propose upgrades, but founder approval remains the hard gate.

## Phase 2 - L10 Deployment Structure

Client deployment should be a method pack, not a hard-coded repo fork:

```text
config/client_vars.yaml     client identity, agents, gates, runtime paths
orchestrator.py             routing, queue, execution lifecycle
memory_manager.py           memory retrieval and reflection
runtime/                    generated queue, logs, and memory stores
03_Company/                 methodology assets and role prompts
00_System_Brain/            protocol and governance assets
```

Minimum install contract for a new client:

1. Copy the repo or packaged vault.
2. Fill `config/client_vars.yaml`.
3. Set API keys as environment variables only.
4. Run `python orchestrator.py submit "task text"`.
5. Review generated task records, deliverables, memories, and blocked approvals.

## Phase 3 - Implemented Scaffold

The first runtime scaffold is intentionally provider-neutral:

- `orchestrator.py` implements file-backed routing, queue state, event logging, and review gates.
- `memory_manager.py` implements append-only JSONL memory with deterministic local embeddings and provider swap points.
- `config/client_vars.yaml` defines the portable client/methodology configuration.

This is L8-ready scaffolding and L9-compatible storage. To reach full L10, connect the `AgentExecutor` adapter to a chosen LLM/provider, add human approval UI, and package method packs per client niche.
