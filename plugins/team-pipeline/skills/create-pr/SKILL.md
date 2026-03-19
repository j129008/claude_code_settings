---
name: create-pr
description: Create a pull request from current branch — pushes, creates PR with summary and test results. Use when code is ready for review.
argument-hint: "[optional title override]"
allowed-tools: [Bash, Read, Glob, Grep]
---

# Create Pull Request

Create a PR from the current working branch.

## Context

- Current branch: !`git branch --show-current`
- Status: !`git status --short`
- Unpushed commits: !`git log --oneline @{upstream}..HEAD 2>/dev/null || git log --oneline -5`

## Steps

### 1. Check state

Verify there are changes to submit and the branch is not main.

### 2. Push branch
```bash
git push -u origin $(git branch --show-current)
```

### 3. Create PR

> **Adapt for your Git platform:**
> - GitHub: `gh pr create`
> - GitLab: `glab mr create`
> - Gitea: `tea pr create`

Example (GitHub):
```bash
gh pr create \
  --title "{short title}" \
  --base main \
  --body "## Summary
- {what changed}
- {why}

## Test Results
{actual test output}

## Checklist
- [ ] Tests pass locally
- [ ] No secrets committed"
```

### 4. Return PR URL

## PR Templates

### Feature
```markdown
## Summary
- Added {feature}

## Implementation
{approach and decisions}

## Test Results
{paste actual output}
```

### Fix
```markdown
## Summary
- Fixed {bug}

## Root Cause
{what caused it}

## Fix
{how it was fixed}

## Test Results
{paste actual output}
```

## Rules
- **PR must include actual test results** — not just a checklist
- Never commit `.env`, credentials, or secrets
- Never force push
- Stage specific files, not `git add -A`
