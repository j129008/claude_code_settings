---
name: ship
description: End-to-end development pipeline — PM spec → implement → QA → PR → code review → merge → retrospective. Ensures every feature goes through the complete workflow.
user-invocable: true
---

# Ship Pipeline

Complete development workflow from spec to ship. Usage: `/ship <feature description>`

## Pipeline Steps

### Step 1: PM Spec (project-manager)
Invoke the `project-manager` agent to write a feature spec:
- Problem definition
- Solution design
- Acceptance criteria
- Priority level

**User must confirm before proceeding to Step 2.**

### Step 2: Implementation (backend-dev / frontend-dev)
Based on the spec, dispatch to the appropriate engineer(s):
- **Backend changes** → `backend-dev` agent
- **Frontend changes** → `frontend-dev` agent
- **Full-stack changes** → both agents (backend first)
- **Infrastructure** → `devops` agent

Run agents in parallel when their work is independent.

### Step 3: QA Testing (qa-tester)
Invoke the `qa-tester` agent to test all changes:
- Must receive **PASS** to continue
- If **FAIL** — fix the bugs and re-test (loop back to Step 2)

### Step 4: Create PR
Create a PR with:
- Feature branch from main
- Clear description with summary + test results
- **Don't stop here to wait for user**

### Step 5: Code Review (code-reviewer)
Invoke the `code-reviewer` agent (Linus Torvalds):
- Must receive **APPROVED** to continue
- If **NEEDS WORK** — fix issues and re-review (loop back to Step 2)
- After 3 failed rounds → stop and ask user

### Step 6: PM Review (project-manager)
Invoke the `project-manager` agent for final product review:
- **SHIP IT** → proceed to merge
- **ITERATE** → loop back to Step 2
- **KILL IT** → stop and discuss with user

### Step 7: Merge & Notify
- Merge the PR (squash merge recommended)
- Notify the team (Slack, email, or your preferred channel)

### Step 8: Retrospective
Run `/retro` to:
- Collect all reviewer feedback from this pipeline run
- Distill actionable rules into `.claude/learnings/` files
- Report what was learned

## Flow Diagram

```
/ship "feature description"
  ↓
[1] PM spec + user confirms
  ↓
[2] Implementation (backend/frontend/devops)
  ↓
[3] QA testing → PASS or loop
  ↓
[4] Create PR
  ↓
[5] Code review → APPROVED or loop
  ↓
[6] PM review → SHIP IT or loop
  ↓
[7] Merge + notify team
  ↓
[8] /retro — retrospective learning
```

## Rules
- Step 1 must be confirmed by user before implementation
- Never skip QA or code review
- Any step failing twice → stop and ask user
- The person who writes code must NOT be the same as the reviewer
