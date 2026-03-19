---
name: retro
description: Retrospective — analyze reviewer feedback from the last pipeline run, distill actionable rules into agent learnings files so agents improve over time. Use after /ship, after significant work, or when pipeline had rejections.
argument-hint: "[optional focus area]"
allowed-tools: [Read, Edit, Write, Glob, Grep]
---

# Retrospective

Analyze feedback from the current session and distill actionable rules into agent learning files.

## When to Run
- After `/ship` completes (automatically as final step)
- Manually via `/retro` after any significant work session
- When a pipeline had rejections or multiple iteration loops

## Process

### Step 1: Collect Feedback
Review the current conversation for:
- **Code Reviewer** verdicts: NEEDS WORK / REJECTED items with file:line references
- **PM** verdicts: ITERATE / KILL IT items with specific complaints
- **QA** verdicts: FAIL items with bug reports
- **User** corrections or confirmations
- Recurring patterns across multiple reviews

### Step 2: Process Compliance Check
Verify against checklist:

| Check | Completed? |
|-------|------------|
| Triggered correct skill | ✅ / ❌ |
| Branch naming correct | ✅ / ❌ |
| PR description complete | ✅ / ❌ |
| Review completed all checks | ✅ / ❌ |
| Team notified after merge | ✅ / ❌ |
| No direct push to main | ✅ / ❌ |

### Step 3: Distill Rules
For each actionable feedback, create a rule that is:
- **Specific and actionable** (not "write better code")
- **Contextual** — when does this apply?
- **Attributed** — which reviewer caught it?
- Skip one-off issues that won't recur

### Step 4: Update Learnings Files
Append rules to `.claude/learnings/` files:

| Issue Type | Target File |
|-----------|-------------|
| Backend | `.claude/learnings/backend-dev.md` |
| Frontend | `.claude/learnings/frontend-dev.md` |
| DevOps | `.claude/learnings/devops.md` |
| Testing | `.claude/learnings/qa-tester.md` |
| Process | `.claude/learnings/workflow.md` |

Format: `- [YYYY-MM-DD] <rule> (source: <reviewer>)`

**Read the file before appending — update similar rules instead of duplicating.**

### Step 5: Report

```markdown
## Retrospective Summary

| Item | Result |
|------|--------|
| Process Compliance | ✅ All passed / ❌ {issues} |
| New Rules Added | {N} rules ({which agents}) |
| Key Themes | {patterns found} |
| Improvements | {actions taken or suggested} |
```

## Rules
- Never delete existing learnings — only add or update
- Keep rules concise: one line each
- Only add generalizable rules for future work
- If no actionable feedback found, say so — don't invent rules
