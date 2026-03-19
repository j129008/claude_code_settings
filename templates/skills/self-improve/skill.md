---
name: self-improve
description: Audit and optimize Claude Code workspace settings — CLAUDE.md, skills, agents, settings, learnings. Use when you want to improve your AI workflow.
user-invocable: true
---

# Self-Improve — Workspace Audit

Review current Claude Code workspace configuration and find improvements.

## Audit Scope

### 1. CLAUDE.md Health
- Is the project description accurate?
- Does the tech stack match actual dependencies?
- Is the skills/agents table up-to-date with `.claude/` directory?
- Any dead links or outdated references?
- Any contradictory instructions?

### 2. Skills Quality
For each skill in `.claude/skills/`:

| Check | Standard |
|-------|----------|
| Trigger words | Cover common ways users ask for this |
| Completeness | No missing steps or outdated commands |
| Overlap | No duplicate functionality with other skills |
| Error handling | Has fallback for failures |
| Accuracy | Referenced commands/tools still exist |

### 3. Agents Quality
For each agent in `.claude/agents/`:

| Check | Standard |
|-------|----------|
| Role clarity | Clear, non-overlapping with other agents |
| Model choice | Appropriate (sonnet for routine, opus for complex) |
| Instructions | Up-to-date with current project |

### 4. Settings
Check `.claude/settings.json` or `.claude/settings.local.json`:

| Check | Standard |
|-------|----------|
| permissions.allow | No unnecessary permissions |
| permissions.deny | Covers dangerous operations |
| permissions.ask | Covers production-affecting operations |
| hooks | Still relevant and working |

### 5. Learnings
Check `.claude/learnings/`:

| Check | Standard |
|-------|----------|
| Outdated rules | Any rules no longer applicable |
| Duplicates | Overlapping rules |
| Coverage | Any gaps from recent reviews |

## Process

### Step 1: Scan
Read all workspace files, produce audit report:

```markdown
## Workspace Audit Report

### Issues Found
| # | Area | Severity | Issue | Fix |
|---|------|----------|-------|-----|
| 1 | CLAUDE.md | Medium | Skills table missing self-improve | Add row |

### Clean Areas
- ✅ Settings permissions configured correctly
- ✅ No outdated learnings
```

### Step 2: Confirm
Show report to user. Ask which items to fix (default: all).

### Step 3: Fix
For confirmed items:
1. Create branch: `chore/self-improve-{date}`
2. Apply fixes
3. Commit (one per area)
4. Push + create PR

## Rules
- Only modify workspace config files — never touch application code
- Don't delete skills/agents — only improve content (unless user explicitly asks)
- Be conservative — list uncertain items for user decision
- Don't modify learnings content — only suggest (learnings reflect real experience)
