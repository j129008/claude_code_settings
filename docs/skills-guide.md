# Skills Guide

How to write effective skills for Claude Code.

## What Are Skills?

Skills are reusable workflow definitions in `.claude/skills/{name}/skill.md`. They:
- Define step-by-step processes (like `/ship`, `/retro`, `/pr-review`)
- Can be invoked by users via slash commands (`/ship add auth`)
- Can be invoked by other skills or agents
- Enforce consistent workflow across the team

## Skill File Format

```markdown
---
name: skill-name
description: One-line description with trigger keywords. Use when user says X, Y, Z.
user-invocable: true  # false for helper skills (loaded by agents, not users)
---

# Skill Title

Brief description of what this skill does and how to use it.

## Steps

### Step 1: {Name}
{Instructions with code examples}

### Step 2: {Name}
{Instructions}

## Rules
- {Constraints and important notes}
```

## Key Design Principles

### 1. One skill = one workflow
Don't combine unrelated operations. Each skill should handle a single, well-defined workflow.

**Bad**: a skill that creates a branch AND deploys to production
**Good**: separate `create-branch` and `deploy` skills

### 2. Include all steps
A skill should be self-contained. Don't assume the user will remember to do something after the skill completes.

**Bad**: "Create a PR" (user must remember to notify team)
**Good**: "Create a PR → merge → notify team"

### 3. Adapt to your Git platform
Skills that interact with Git hosting need platform-specific commands:

| Platform | PR Create | PR Merge | PR Review |
|----------|-----------|----------|-----------|
| GitHub | `gh pr create` | `gh pr merge` | `gh pr review` |
| GitLab | `glab mr create` | `glab mr merge` | `glab mr approve` |
| Gitea | `tea pr create` | `tea pr merge` | `tea pr approve` |

### 4. Include fail loops
Critical skills should handle failures gracefully:

```markdown
### Step 3: Code Review
- If APPROVED → continue
- If NEEDS WORK → fix and re-review (max 3 rounds)
- If still failing → stop and ask user
```

### 5. User-invocable vs helper skills

**User-invocable** (`user-invocable: true`):
- Triggered via `/skill-name` in chat
- Should be discoverable — clear name and description
- Examples: `/ship`, `/retro`, `/pr-create`

**Helper skills** (`user-invocable: false`):
- Loaded by agents or other skills
- Provide reference data, not workflows
- Examples: `design-system` (color tokens), `ui-review` (checklist)

## Core Skills Worth Having

| Skill | Purpose | Complexity |
|-------|---------|------------|
| **ship** | End-to-end pipeline (spec → implement → test → review → merge) | High |
| **retro** | Post-pipeline retrospective, updates learnings | Medium |
| **create-branch** | Standard branch creation with naming conventions | Low |
| **pr-create** | Push + create PR with proper description | Low |
| **pr-review** | 8-point review with auto-fix loop | High |
| **self-improve** | Audit and optimize workspace config | Medium |

## Tips

- **Trigger keywords in description** are important — Claude Code uses them to match user intent to skills. Include both formal terms ("pull request") and casual ones ("PR", "merge").
- **Don't over-specify**: skills should be detailed enough to follow but flexible enough to adapt. Don't hardcode paths or values that vary by project.
- **Test your skills**: run each skill end-to-end at least once. Skills with broken steps erode trust fast.
- **Iterate**: your first version won't be perfect. The `/retro` skill exists precisely to capture what went wrong and improve.
