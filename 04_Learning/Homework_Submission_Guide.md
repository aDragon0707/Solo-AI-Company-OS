> 🌐 Language: **English** | [[zh/04_Learning/Homework_Submission_Guide.md|简体中文]]
# Homework Submission Guide

**Purpose:** Explain how the founder submits learning work to AI-05.

---

## 1. Submission Locations

Written homework:

```text
04_Learning/Submissions
```

Practice code:

```text
04_Learning/Submissions/code
```

---

## 2. Homework Philosophy

Every homework answer should follow:

```text
Architectural Intent First, Code Deconstruction Second.
```

Start by explaining why the module exists and where it fits. Then explain the critical-path code.

Do not start with syntax unless the assignment specifically asks for syntax.

---

## 3. Written Homework Template

```markdown
# YYYY-MM-DD - [Topic]

## Module Or Concept
[Name of module, file, or concept]

## Architectural Intent
This exists because:

## Topology
It sits after:
It sits before:

## Input / Output
Input:
Output:

## Risk Boundary
It must never:

## Code Deconstruction
The critical-path code is:
It works by:

## What I Do Not Understand
1.
2.

## What I Want AI-05 To Review
[Specific question]
```

---

## 4. AI-05 Review Request

Copy this:

```text
AI-05, please review my homework:
Written homework: [Vault Root]/04_Learning/Submissions/[file].md
Practice code: [Vault Root]/04_Learning/Submissions/code/[file].py

Use the teaching standard:
Architectural Intent First, Code Deconstruction Second.

Please respond with:
1. what I understood correctly
2. what is inaccurate or vague
3. the better architectural explanation
4. the one code detail I should understand now
5. one next assignment
6. whether AI-02 review is needed
```

---

## 5. Production Boundary

Learning code stays in `Submissions/code`.

If a learning exercise should become a real system change, AI-05 must hand it to AI-02 for review.
