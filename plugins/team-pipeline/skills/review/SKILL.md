---
name: review
description: Linus Torvalds-style code review with 8-point checklist. Auto-fixes issues and re-reviews until all checks pass, then merges. Use when reviewing code changes, PRs, or diffs.
argument-hint: "[PR number, branch name, or file paths]"
allowed-tools: [Read, Edit, Write, Glob, Grep, Bash, Agent]
---

# Code Review — Linus Mode

Strict 8-point code review with automatic fix-and-retry loop.

## Context

- Current branch: !`git branch --show-current`
- Recent changes: !`git log --oneline -5`

## Process

### Step 1: Identify what to review

If a PR number is given, fetch the diff. Otherwise review current branch changes:
```bash
git diff main...HEAD --name-only  # Changed files
git diff main...HEAD              # Full diff
```

### Step 2: Read ALL changed files in full

Don't just skim the diff — read every changed file completely.

### Step 3: Run 8-point checklist

**Each item must be explicitly ✅ or ❌ — no skipping.**

| # | Check | Auto-Reject Condition |
|---|-------|-----------------------|
| 1 | **Correctness** | Logic errors, unhandled edge cases |
| 2 | **Code Quality** | Massive duplication, confusing naming, over-engineering |
| 3 | **Security** | Any vulnerability (injection, secrets, unvalidated input) |
| 4 | **Performance** | N+1 queries, no pagination, O(n²) when O(n) works |
| 5 | **Backward Compatibility** | Unmarked breaking API/DB changes |
| 6 | **Project Conventions** | Violates established patterns |
| 7 | **Simplicity** | Factory for one type, wrapper around wrapper |
| 8 | **Code Hygiene** | Debug logs, commented-out blocks, `data`/`temp` naming |

### Step 4: Verdict

- **All ✅** → APPROVED (Step 5a)
- **Any ❌** → Auto-fix loop (Step 5b)

### Step 5a: Approved

Report the review results. If reviewing a PR, approve and merge.

### Step 5b: Not approved → Fix loop

1. Output review report with all ❌ items
2. Fix issues directly in the code
3. Commit: `fix: address review feedback - {description}`
4. Re-review from Step 3

**Safety limit: max 3 rounds.** After 3 failures, stop and report to user.

## Review Report Format

```markdown
## Code Review: {what was reviewed}

### Round {n}

| # | Check | Result | Details |
|---|-------|--------|---------|
| 1 | Correctness | ✅/❌ | {findings} |
| 2 | Code Quality | ✅/❌ | {findings} |
| 3 | Security | ✅/❌ | {findings} |
| 4 | Performance | ✅/❌ | {findings} |
| 5 | Backward Compat | ✅/❌ | {findings} |
| 6 | Conventions | ✅/❌ | {findings} |
| 7 | Simplicity | ✅/❌ | {findings} |
| 8 | Code Hygiene | ✅/❌ | {findings} |

### Linus Says
> {1-3 sentence verdict in Linus's voice — praise good code, roast bad code}

### Issues (❌ items)
1. **[Severity]** {description} — `{file}:{line}`
   - Fix: {specific fix}

### Verdict: ✅ APPROVED / ⏳ Fixing...
```

## Self-Improvement
When issues are found, append rules to `.claude/learnings/{role}.md`:
Format: `- [YYYY-MM-DD] <concise rule> (source: Linus Torvalds)`

## Rules
- Every check needs specific code evidence — no "looks fine"
- Read entire diff before reviewing
- Only fix flagged issues — don't refactor unrelated code
- Re-review checks ALL items (fixes can introduce new issues)
