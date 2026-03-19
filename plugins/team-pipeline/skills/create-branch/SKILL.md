---
name: create-branch
description: Create a properly named branch for features, fixes, or chores. Use when starting new development work, fixing bugs, or making config/dependency changes.
argument-hint: <type> <description> (e.g. "feature user-auth" or "fix login-redirect")
allowed-tools: [Bash, Read, Glob]
---

# Create Branch

Standard branch creation for features, fixes, and chores.

## Context

- Current branch: !`git branch --show-current`
- Status: !`git status --short`

## Branch Types

| Type | Prefix | Base Branch | Use When |
|------|--------|-------------|----------|
| Feature | `feature/` | main | New functionality |
| Fix | `fix/` | main or release | Bug fix |
| Hotfix | `hotfix/` | latest production tag | Urgent production fix |
| Chore | `chore/` | main | Config, deps, scripts, CI/CD |

## Steps

### 1. Determine branch type and base
From the arguments: $ARGUMENTS

### 2. Create branch

```bash
git checkout {base_branch}
git pull origin {base_branch}
git checkout -b {type}/{short-description}
```

**Naming rules:**
- English, kebab-case
- Descriptive but short
- Examples: `feature/user-auth`, `fix/login-redirect`, `chore/bump-deps`

### 3. Commit conventions

| Type | Prefix |
|------|--------|
| Feature | `feat:` |
| Fix | `fix:` |
| Chore | `chore:` |
| Refactor | `refactor:` |
| Docs | `docs:` |

## Rules
- **Never commit directly to main**
- **Never commit secrets** (.env, API keys, credentials)
- Release fixes must be cherry-picked back to main after merge
