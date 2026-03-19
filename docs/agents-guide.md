# Sub-Agents Guide

How to design effective sub-agents for Claude Code.

## What Are Sub-Agents?

Sub-agents are specialized AI personas defined in `.claude/agents/`. Each agent has:
- A **personality** (real-world figure whose style they channel)
- A **role** (specific responsibilities)
- A **model** (sonnet for routine work, opus for complex reasoning)
- **Tools** they can access
- **Self-improvement** via learnings files

## Key Design Principles

### 1. Keep the team small
5-6 agents is the sweet spot. More leads to overlapping roles and trigger confusion.

**Recommended team:**
| Agent | Role | When to use |
|-------|------|-------------|
| project-manager | Specs, priorities, final review | Start and end of features |
| backend-dev | Server-side code | API, database, backend logic |
| frontend-dev | Client-side code | UI, components, styling |
| code-reviewer | Quality gate | Every PR before merge |
| qa-tester | Testing | After implementation, before review |

Optional: `devops`, `tech-writer`

### 2. No role overlap
Each agent should have a clear, exclusive domain. If you're unsure which agent handles something, your boundaries aren't clear enough.

**Bad**: backend-dev and devops both handle "deployment scripts"
**Good**: backend-dev handles app code, devops handles infrastructure and CI/CD

### 3. Personality matters
The personality isn't just flavor text — it shapes how the agent approaches problems:

- **Linus Torvalds** as reviewer → brutally honest, catches over-engineering
- **DHH** as backend dev → convention-over-configuration, pragmatic
- **Dan Abramov** as frontend dev → composable components, minimal state

Choose personalities whose values match the quality standards you want.

### 4. Self-improvement loop
Every agent should:
1. Read their learnings file before starting work
2. Contribute to learnings files when they find issues
3. Never repeat a mistake that's already documented

## Agent File Format

```markdown
---
name: agent-name
description: One-line description with trigger keywords — Claude Code uses this to decide when to invoke the agent
model: sonnet  # or opus for complex work
tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Edit
  - Write
---

You are {Personality Name}, {brief context about who they are}.

## Your Philosophy
- "Quote that captures their approach"
- Key principles (3-5 bullets)

## Your Tech Stack
- Framework, language, tools specific to this project

## Your Coding Style
- How this personality writes code (5-8 bullets)

## Self-Improvement
Before starting any task, read `.claude/learnings/{role}.md` for rules learned from past reviews.

## Your Workflow
1. Read learnings first
2. Read existing code to understand patterns
3. Implement following project conventions
4. Test your changes
```

## Tips

- **description field is critical** — Claude Code matches user requests against descriptions to decide which agent to invoke. Include all relevant keywords.
- **model choice**: use `sonnet` for most work (faster, cheaper). Reserve `opus` for complex architectural decisions or multi-step reasoning.
- **tools**: only grant tools the agent actually needs. A reviewer doesn't need `Write`; a writer doesn't need `Bash`.
- **Keep agents focused**: a 200-line agent definition is too long. If you need that much context, split it into the agent definition + a skill it can load.
