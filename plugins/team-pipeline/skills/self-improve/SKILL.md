---
name: self-improve
description: Audit and optimize Claude Code workspace — CLAUDE.md, skills, agents, settings, learnings. Use when you want to review your AI workflow configuration for improvements.
allowed-tools: [Read, Edit, Write, Glob, Grep, Bash]
---

# Self-Improve — Workspace Audit

Review current Claude Code workspace configuration and find improvements.

## Audit Scope

### 1. CLAUDE.md Health
- Is the project description accurate?
- Does the tech stack match actual dependencies?
- Is the skills/agents table up-to-date with `.claude/` directory?
- Any dead links or outdated references?

### 2. Skills Quality
For each skill in `.claude/skills/`:

| Check | Standard |
|-------|----------|
| Trigger words | Cover common ways users ask for this |
| Completeness | No missing steps or outdated commands |
| Overlap | No duplicate functionality with other skills |
| Accuracy | Referenced commands/tools still exist |

### 3. Agents Quality
For each agent in `.claude/agents/`:

| Check | Standard |
|-------|----------|
| Role clarity | Non-overlapping with other agents |
| Model choice | Appropriate (sonnet for routine, opus for complex) |
| Instructions | Up-to-date with current project |

### 4. Settings
| Check | Standard |
|-------|----------|
| permissions.allow | No unnecessary permissions |
| permissions.deny | Covers dangerous operations |
| hooks | Still relevant and working |

### 5. Learnings
| Check | Standard |
|-------|----------|
| Outdated rules | Any no longer applicable |
| Duplicates | Overlapping rules |
| Coverage | Gaps from recent reviews |

## Process

### Step 1: Scan
Read all workspace files, produce audit report:

```markdown
## Workspace Audit Report

### Issues Found
| # | Area | Severity | Issue | Fix |
|---|------|----------|-------|-----|
| 1 | CLAUDE.md | Medium | Skills table outdated | Update |

### Clean Areas
- ✅ Settings permissions correct
- ✅ No outdated learnings
```

### Step 2: Confirm
Show report to user. Ask which items to fix (default: all).

### Step 3: Fix
Apply confirmed fixes, commit to a new branch, create PR.

## Rules
- Only modify workspace config files — never application code
- Don't delete skills/agents — only improve (unless user asks)
- Be conservative — list uncertain items for user decision
- Don't modify learnings content — only suggest
