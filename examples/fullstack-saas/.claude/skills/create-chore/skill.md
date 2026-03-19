---
name: create-branch
description: Create a properly named branch for features, fixes, or chores. Use when starting new work.
user-invocable: true
---

# Create Branch

Standard branch creation workflow for features, fixes, and chores.

## Branch Types

| Type | Prefix | Base Branch | Use When |
|------|--------|-------------|----------|
| Feature | `feature/` | main | New functionality |
| Fix | `fix/` | main or release | Bug fix |
| Hotfix | `hotfix/` | latest production tag | Urgent production fix |
| Chore | `chore/` | main | Config, deps, scripts, CI/CD |

## Steps

### 1. Determine branch type and base

Ask the user or infer from context:
- New feature → `feature/` from `main`
- Bug fix → `fix/` from `main` (or release branch if fixing a release)
- Hotfix → `hotfix/` from latest production tag
- Config/deps → `chore/` from `main`

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
| CI | `ci:` |

## Important Rules

- **Never commit directly to main** — always create a branch
- **Never commit secrets** (.env, API keys, credentials)
- Release fixes must be cherry-picked back to main after merge
- Hotfixes must be cherry-picked back to main (and release branch if exists)
