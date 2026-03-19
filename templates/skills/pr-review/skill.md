---
name: pr-review
description: Review a PR with Linus Torvalds-style strictness. Auto-fixes issues and re-reviews until all 8 checks pass, then merges.
user-invocable: true
---

# PR Review — Linus Mode

Strict code review with automatic fix-and-retry loop.

## Process

### 1. Get PR info
```bash
# Adapt for your platform
gh pr view {number}
gh pr diff {number}
```

### 2. Checkout PR branch
```bash
git fetch origin {head_branch}
git checkout {head_branch}
git pull origin {head_branch}
```

### 3. Run 8-point checklist

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

### 4. Verdict

- **All ✅** → Approve + Merge (Step 5a)
- **Any ❌** → Auto-fix loop (Step 5b)

### 5a. Approved → Merge + Notify

1. Approve the PR
2. Merge (squash recommended)
3. Switch to base branch and pull
4. Notify team (Slack/email/etc.)

### 5b. Not approved → Fix loop

1. Output review report with all ❌ items
2. Fix issues on the PR branch
3. Commit: `fix: address review feedback - {description}`
4. Push
5. Re-review from Step 3

**Safety limit: max 3 rounds.** After 3 failures, stop and report to user.

## Review Report Format

```markdown
## PR Review: #{number} — {title}

### Round {n}

| # | Check | Result | Details |
|---|-------|--------|---------|
| 1 | Correctness | ✅/❌ | {findings} |
| ... | ... | ... | ... |

### Linus Says
> {verdict in Linus's voice — praise good code, roast bad code}

### Issues
1. **[Critical]** {description} — `{file}:{line}`
   - Fix: {specific fix}

### Verdict: ✅ APPROVED / ⏳ Fixing...
```

## Rules
- Every check needs specific code evidence — no "looks fine"
- Read entire diff before reviewing
- Only fix flagged issues — don't refactor unrelated code
- Commit messages must describe what was fixed
- Re-review checks ALL items (fixes can introduce new issues)
