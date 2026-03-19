---
name: pr-create
description: Create a pull request from current branch. Pushes branch, creates PR with summary and test results.
user-invocable: true
---

# Create Pull Request

Create a PR from the current working branch.

## Steps

### 1. Check state
```bash
git status
git diff
git branch --show-current
git log --oneline origin/{base}..HEAD
```

### 2. Push branch (if not pushed)
```bash
git push -u origin $(git branch --show-current)
```

### 3. Create PR

> **Adapt this command for your Git platform:**
> - GitHub: `gh pr create`
> - GitLab: `glab mr create`
> - Gitea: `tea pr create`
> - Bitbucket: use API

Example (GitHub):
```bash
gh pr create \
  --title "{short title}" \
  --base main \
  --body "## Summary
- {what changed}
- {why it changed}

## Test Results
{actual test output from local testing}

## Checklist
- [ ] Tests pass locally
- [ ] No secrets committed
- [ ] Breaking changes documented"
```

### 4. Confirm PR creation
Show the PR URL to the user.

## PR Description Template

### Feature PR
```markdown
## Summary
- Added {feature description}

## Implementation
{design decisions, approach}

## Test Results
{paste actual test output}
```

### Fix PR
```markdown
## Summary
- Fixed {bug description}

## Root Cause
{what caused the bug}

## Solution
{how it was fixed}

## Test Results
{paste actual test output}
```

## Rules
- **PR must include actual test results** — not just a checklist
- Never commit `.env`, credentials, or secrets
- Never force push
- Stage specific files, not `git add -A`
