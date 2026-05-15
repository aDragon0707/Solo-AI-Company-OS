# Skill Library

**Purpose:** Starter reusable skills for a small human-AI company.

These skills are intentionally generic. Customize them after real worklogs prove what works in your own vault.

---

## AI-01 Skills

### Task Breakdown And Routing

Use when the founder gives a broad goal, scattered thoughts, or a messy chat transcript.

Steps:

1. Identify the founder decision or missing decision.
2. Split the goal into concrete tasks.
3. Assign each task to Founder, AI-01, AI-02, AI-03, AI-04, or AI-05.
4. Mark blockers and handoffs.
5. Update dashboard or worklog index only if state changed.

Do not turn founder ideas into confirmed decisions.

### State Sync

Use when dashboards, worklogs, and current priorities may be out of date.

Steps:

1. Read founder decision log, company dashboard, and worklog index.
2. Compare current state against latest worklogs.
3. Mark what is verified, blocked, unknown, or outdated.
4. Update only summary state, not source truth.

Do not make the dashboard look more mature than the underlying files support.

### Handoff Writing

Use when another AI employee must continue the work.

Steps:

1. Name the receiving AI employee.
2. State why the handoff is needed.
3. List input files and current state.
4. List what the next AI must produce.
5. List what the next AI must not assume.

Do not write a vague handoff that depends on chat memory.

### Worklog Index Maintenance

Use after new worklogs are created.

Steps:

1. Find new worklog files.
2. Add concise rows to the worklog index.
3. Preserve status honestly.
4. Surface missing or incomplete worklogs.

Do not rewrite completed worklogs unless explicitly asked.

---

## AI-02 Skills

### Project Truth Check

Use before technical or operational facts are used by other AI employees.

Steps:

1. Identify the claim or output that needs verification.
2. Read the source files or artifacts behind it.
3. Separate verified facts, uncertainty, failures, and assumptions.
4. Provide conservative facts to AI-03 or AI-04.

Do not polish uncertain output into confident language.

### Verification Record

Use after a build, test, analysis, or operational check.

Steps:

1. Record what was checked.
2. Record commands or methods used.
3. Record pass, fail, skipped, and not-run items.
4. State what remains unverified.

Do not silently drop failed checks.

### Conservative Technical Summary

Use when technical work must be explained to non-technical readers.

Steps:

1. Start with what is known.
2. Name the evidence or source files.
3. Explain limits in plain language.
4. Avoid claims that require review by AI-04.

Do not turn technical possibility into business certainty.

---

## AI-03 Skills

### Customer-Facing Draft

Use when creating emails, landing-page text, sales notes, follow-ups, or offer drafts.

Steps:

1. Read founder decisions and current product/offer files.
2. Ask AI-02 for facts if project truth is unclear.
3. Ask AI-04 for review if claims are sensitive.
4. Draft language for founder review.
5. Mark what the founder must approve before sending.

Do not send messages as the founder or approve pricing.

### Commercial Action Breakdown

Use when the founder wants revenue progress but the path is unclear.

Steps:

1. Convert the goal into customer, asset, channel, and follow-up tasks.
2. Identify founder decisions needed.
3. Identify which claims need AI-02 or AI-04 review.
4. Produce the smallest next action.

Do not confuse activity with revenue progress.

---

## AI-04 Skills

### Claim Boundary Review

Use before public, customer-facing, academic, policy, legal, financial, or high-stakes wording leaves the vault.

Steps:

1. Identify each claim.
2. Check whether each claim is supported, unsupported, or too strong.
3. Replace overconfident wording with safer wording.
4. Name missing evidence or expert review.

Do not invent authority, approval, proof, or certainty.

### Public Language De-Risking

Use when a draft sounds impressive but may overpromise.

Steps:

1. Remove unsupported superlatives.
2. Keep uncertainty visible.
3. Separate observation, interpretation, and recommendation.
4. Return safer wording for founder approval.

Do not make the text toothless; make it honest.

---

## AI-05 Skills

### Architectural Intent First

Use when teaching code, tools, workflows, or system design to the founder.

Steps:

1. Explain why the component exists.
2. Explain where it fits in the system.
3. Explain what risk or decision boundary it protects.
4. Only then explain critical implementation details.

Do not start with syntax unless the founder asks for syntax.

### Code Deconstruction

Use when the founder wants to understand a code path or technical artifact.

Steps:

1. Name input, process, output, and failure modes.
2. Explain the smallest useful path first.
3. Translate jargon into plain language.
4. Give one practice assignment.

Do not hide uncertainty behind teaching confidence.

### Experience To Learning Material

Use when a completed task taught the founder something reusable.

Steps:

1. Extract the lesson from the worklog.
2. Explain it in founder-friendly language.
3. Add a small exercise or checklist.
4. Link back to the original worklog.

Do not turn private project context into public teaching material without review.

---

## Cross-Role Skills

### Obsidian Link Maintenance

Use when important notes are hard to navigate.

Steps:

1. Find orphan or under-linked notes.
2. Add links to the right dashboard, map, worklog index, or parent note.
3. Preserve the meaning of the note.
4. Report links added and links still needed.

Do not use links to imply decisions or dependencies that do not exist.

### Worklog To Skill Distillation

Use when a completed worklog contains a repeatable way of working.

Steps:

1. Read the worklog and any changed files.
2. Extract the reusable pattern.
3. Remove project-specific details.
4. Choose assigned AI employees.
5. Draft a skill using `SKILL_TEMPLATE.md`.

Do not create a skill from a one-off result that cannot be repeated.

### Doc Memory Spine Maintenance

Use when the vault's operating memory needs to stay coherent across dashboards, MOCs, AI prompts, worklogs, handoffs, and source-of-truth rules.

Steps:

1. Read the smallest set of current memory files.
2. Resolve conflicts using the source-of-truth order.
3. Find stale paths, broken links, missing owners, and outdated instructions.
4. Apply targeted edits only.
5. Sync dashboards, MOCs, worklog indexes, or skill maps when state changed.
6. Report uncertainty instead of hiding it.

Do not rewrite history, invent progress, or make old worklogs look cleaner than they were.

Reference:

- `00_System_Brain/Doc_Memory_Spine_Skill.md`
