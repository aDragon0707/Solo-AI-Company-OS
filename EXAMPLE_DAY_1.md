# Example Day 1

**Purpose:** Show what a filled-in first day can look like without using a real company, client, or product.

This example is fully fictional. Replace the names, goals, and constraints with your own.

---

## Fictional Setup

| Field | Example |
|---|---|
| Company | Northstar Notes |
| Product | BriefForge |
| Founder | Solo operator |
| Current stage | idea to first useful prototype |
| Main risk | building features before the offer is clear |

BriefForge is a fictional tool that helps consultants turn long client notes into short follow-up memos.

---

## 1. Founder Thinking Inbox

File:

```text
01_Founder/FOUNDER_Thinking_Inbox.md
```

Example entry:

```markdown
## 2026-05-02 - Raw Thought

I keep asking AI for strategy, copy, and product plans, but the output keeps mixing together.

Current anxiety:
- I may be building too much before proving the first buyer problem.
- I do not want AI to turn an idea into a promise before I approve it.
- I need one place where decisions are official.

Possible first customer:
- independent consultants who write many client follow-ups

Unclear:
- whether the first product should be a template vault, a small app, or a service package
```

---

## 2. Founder Decision Log

File:

```text
01_Founder/FOUNDER_Decision_Log.md
```

Example entry:

```markdown
## DEC-20260502-001 - Establish AI Operating Boundaries

Status: Active
Date: 2026-05-02

Decision:
AI employees may draft options, plans, and critiques, but they may not turn any draft into a founder decision.

Reason:
The company needs durable memory, but the founder must remain the final owner of strategy, promises, and risk.

Applies To:
- product direction
- customer claims
- pricing
- public writing
- technical scope

AI Instruction:
When a task requires a decision, mark it as [Needs Founder Decision] instead of guessing.

Review Date:
2026-05-09
```

---

## 3. First AI-01 Request

File to open:

```text
03_Company/AI_Employees/AI-01_Founder_Office/START_PROMPT.md
```

Example founder message:

```text
AI-01, read the founder decision log, Obsidian home, company maps, and worklog index.

Then give me:
1. top 3 priorities for Day 1
2. current blockers
3. founder decisions needed
4. which AI role should own the next step
```

Example AI-01 output summary:

```markdown
## AI-01 Day 1 Routing

Top priorities:
1. Define the first buyer and painful use case.
2. Create one clear offer page draft.
3. Ask AI-04 to review the claims before sharing anything.

Current blockers:
- no confirmed buyer segment
- no approved public promise
- no worklog yet

Founder decisions needed:
- choose first buyer segment
- decide whether Day 1 output is a service, template, or app prototype

Next owner:
- AI-03 should draft buyer assumptions and outreach angles.
- AI-04 should review claim boundaries after the draft exists.
```

---

## 4. First Worklog

File:

```text
03_Company/AI_Worklogs/WORKLOG_TEMPLATE.md
```

Example filled entry:

```markdown
## AI-01 Worklog - 2026-05-02 - Day 1 System Routing

### Task Received
- Read the system entry files and give the founder Day 1 priorities, blockers, decisions needed, and next AI owner.

### Files Read
- OBSIDIAN_HOME.md
- 01_Founder/FOUNDER_Decision_Log.md
- 03_Company/MOC_Company.md
- 03_Company/AI_Worklogs/WORKLOG_INDEX.md

### Work Completed
- Confirmed that founder decisions are the source of truth.
- Identified Day 1 priorities.
- Flagged missing buyer and offer decisions.
- Recommended AI-03 for first buyer work and AI-04 for claim review.

### Files Changed
- None.

### Verification Status
- Not run.
- This was a planning and routing task only.

### Not Completed
- No buyer segment chosen yet.
- No offer page drafted yet.

### Needs Founder
- Pick the first buyer segment.
- Decide whether the first output is a service, template, or app prototype.

### Needs Another AI
- AI-03 for buyer and offer draft.
- AI-04 for claim review after draft exists.

### Handoff For Next AI
Handoff To: AI-03 Growth / Revenue
Reason For Handoff: Need first buyer assumptions and outreach angle.
Current State: Day 1 priorities are set, but buyer and offer are not approved.
Files Read: OBSIDIAN_HOME.md, FOUNDER_Decision_Log.md, MOC_Company.md, WORKLOG_INDEX.md
Files Changed: None
Verification Status: Planning only
Known Gaps: No founder-approved buyer segment
Next AI Needs: Draft buyer options without making final decisions
Do Not Assume: Do not claim the product is validated
Founder Decision Needed: first buyer segment

### Next Recommendation
- Founder chooses the first buyer segment before AI-03 writes outreach.
```

---

## 5. What Day 1 Should Feel Like

After one short session, you should have:

- one official decision
- one AI role activated
- one worklog created
- one clear next owner
- one list of founder decisions still needed

That is enough. The point of Day 1 is not to fill every file. The point is to stop losing the company inside chat history.
