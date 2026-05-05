> 🌐 Language: **English** | [[zh/04_Learning/00_Project_Map_For_Founder.md|简体中文]]
# Project Map For Founder

**Purpose:** Help the founder understand My AI Collaboration OS by topology before code.

---

## 1. Generic Project Flow

Use this abstract map:

```text
[Plan / Intent]
  -> [Input Collection]
  -> [Data Capture Component]
  -> [Integrity Verification]
  -> [Analysis / Review]
  -> [Analytical Output]
  -> [Customer or Internal Decision]
```

---

## 2. How To Read A Module

For each module, answer:

| Question | Answer |
|---|---|
| Why does it exist? | [Intent] |
| What comes before it? | [Upstream module] |
| What comes after it? | [Downstream module] |
| What does it consume? | [Input] |
| What does it produce? | [Output] |
| What risk does it protect? | [Risk] |
| What must it not do? | [Boundary] |

---

## 3. What To Ignore At First

At the beginning, do not chase:

- every helper function
- every syntax detail
- every configuration option
- every edge case

Find the main path first. Details matter later.

---

## 4. Founder-Level Passing Standard

You pass when you can say:

```text
This module exists to protect [intent].
It receives [input].
It produces [output].
If it fails, [risk] happens.
It must not [boundary].
```
