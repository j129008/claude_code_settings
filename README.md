# Claude Code Settings — Team Workflow Templates

Production-tested Claude Code configurations for team development workflows.

These templates implement a **sub-agent team model** where each agent has a distinct personality, role, and set of responsibilities — turning Claude Code into a full development pipeline.

## What's Inside

```
examples/
├── fullstack-saas/     # Multi-repo SaaS with PR workflow, CI/CD, Slack notifications
└── solo-project/       # Single-repo project with full pipeline

templates/              # Copy-paste building blocks
├── agents/             # Sub-agent definitions (PM, backend, frontend, reviewer, etc.)
├── skills/             # Reusable skill definitions (ship, retro, PR workflow, etc.)
├── hooks/              # Stop hooks for pipeline enforcement
└── learnings/          # Self-improving agent knowledge base

docs/
├── agents-guide.md     # How to design sub-agents
├── skills-guide.md     # How to write skills
└── learnings-guide.md  # How the self-improvement loop works
```

## Key Concepts

### 1. Sub-Agent Team
Each agent is a named personality with specific expertise:

| Agent | Personality | Role |
|-------|-------------|------|
| **project-manager** | Steve Jobs | Product vision, specs, prioritization |
| **backend-dev** | DHH / Guido | Backend implementation |
| **frontend-dev** | Dan Abramov / Lea Verou | Frontend implementation |
| **code-reviewer** | Linus Torvalds | Code review, merge gatekeeper |
| **qa-tester** | James Whittaker | Testing, bug catching |
| **tech-writer** | Donald Knuth | Documentation |

### 2. Ship Pipeline (`/ship`)
End-to-end development workflow:
```
/ship "add user authentication"
  ↓
[1] PM writes spec → user confirms
  ↓
[2] Engineers implement (backend/frontend/devops)
  ↓
[3] QA tests → PASS or loop back
  ↓
[4] Create PR
  ↓
[5] Code review → APPROVED or loop back
  ↓
[6] PM final review → SHIP IT
  ↓
[7] Merge + notify team
  ↓
[8] /retro — retrospective learning
```

### 3. Self-Improving Agents (`/retro`)
After each pipeline run, the `/retro` skill:
- Collects all reviewer feedback (rejections, iterations)
- Distills actionable rules into `.claude/learnings/` files
- Agents read their learnings before starting any task
- **Result: agents get better over time, never repeating the same mistakes**

### 4. Strict Code Review
The code reviewer (Linus Torvalds personality) checks 8 dimensions:

1. Correctness — logic, edge cases, error handling
2. Code quality — readability, naming, DRY
3. Security — injection, secrets, input validation
4. Performance — N+1, pagination, unnecessary loops
5. Backward compatibility — API changes, migrations
6. Project conventions — existing patterns
7. Simplicity — over-engineering, unnecessary abstractions
8. Code hygiene — dead code, debug remnants

Failed reviews trigger **automatic fix + re-review loops** (max 3 rounds).

## Quick Start

### Option A: Start from an example
```bash
# Copy the example that matches your project
cp -r examples/solo-project/.claude /your/project/.claude
cp examples/solo-project/CLAUDE.md /your/project/CLAUDE.md

# Edit CLAUDE.md to match your project
```

### Option B: Build from templates
```bash
# Copy just the pieces you need
mkdir -p /your/project/.claude/{agents,skills,learnings}

# Pick agents
cp templates/agents/project-manager.md /your/project/.claude/agents/
cp templates/agents/code-reviewer.md /your/project/.claude/agents/

# Pick skills
cp -r templates/skills/ship /your/project/.claude/skills/
cp -r templates/skills/retro /your/project/.claude/skills/
```

### Option C: Minimal setup (just the reviewer)
```bash
# If you only want strict code review
mkdir -p /your/project/.claude/agents
cp templates/agents/code-reviewer.md /your/project/.claude/agents/
```

## Customization

### Swap agent personalities
The personalities are just prompts — swap them for anyone:
- Backend: DHH → Rob Pike (Go style) → José Valim (Elixir style)
- Frontend: Dan Abramov → Evan You (Vue) → Rich Harris (Svelte)
- Reviewer: Linus Torvalds → your tech lead's style

### Adapt to your stack
Each agent has a "Tech Stack" section — update it:
```markdown
## Tech Stack
- **Backend**: Django 5.1, Python 3.10+, DRF
- **Frontend**: Next.js 15, React 19, TypeScript
```

### Add your Git platform
The examples use generic `git` commands. Adapt PR skills to your platform:
- **GitHub**: `gh pr create/merge/review`
- **GitLab**: `glab mr create/merge`
- **Gitea**: `tea pr create/merge`
- **Bitbucket**: `bb pr create`

## Settings Reference

### `settings.json` (user-level, `~/.claude/`)
```json
{
  "permissions": {
    "allow": ["Read", "Edit", "Write", "Glob", "Grep", "Bash", "WebFetch"],
    "deny": ["Bash(rm -rf /)", "Bash(git push --force*)"],
    "ask": ["Bash(git push origin --tags)", "Bash(terraform apply*)"]
  }
}
```

### `settings.local.json` (project-level, `.claude/`)
```json
{
  "permissions": {
    "allow": ["mcp__playwright__*"],
    "deny": ["Bash(rm -rf /)"],
    "ask": ["Bash(git reset --hard*)"]
  },
  "hooks": {
    "Stop": [{ "hooks": [{ "type": "command", "command": ".claude/hooks/pipeline-check.sh" }] }]
  }
}
```

## License

MIT — use however you want.
