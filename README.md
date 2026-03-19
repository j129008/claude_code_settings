# Claude Code Settings — Team Workflow Templates

Production-tested Claude Code configurations for team development workflows.

These templates implement a **sub-agent team model** where each agent has a distinct personality, role, and set of responsibilities — turning Claude Code into a full development pipeline.

## Install as Plugin

```bash
# Add this repo as a marketplace (use your Git hosting URL)
claude plugin marketplace add git@your-server:org/claude-code-settings.git

# Install the team-pipeline plugin
claude plugin install team-pipeline@claude-code-settings
```

After installing, you get these slash commands:

| Command | Description |
|---------|-------------|
| `/ship <task>` | Full pipeline: PM spec → implement → QA → review → merge → retro |
| `/review` | Linus-style 8-point code review with auto-fix loop |
| `/retro` | Retrospective: distill learnings so agents improve over time |
| `/create-branch` | Create feature/fix/chore branch with conventions |
| `/create-pr` | Push and create PR with test results |
| `/self-improve` | Audit workspace config for improvements |

## What's Inside

```
plugins/
└── team-pipeline/        # Installable plugin
    ├── .claude-plugin/
    ├── agents/            # 7 sub-agents (PM, engineers, reviewer, QA, etc.)
    ├── skills/            # 6 slash commands
    ├── hooks/             # Pipeline enforcement
    └── learnings/         # Self-improvement templates

examples/                  # Complete project configurations
├── fullstack-saas/        # Multi-repo SaaS setup
└── solo-project/          # Single-repo project setup

templates/                 # Copy-paste building blocks
docs/                      # Guides for agents, skills, and learnings
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
| **devops** | Kelsey Hightower | Infrastructure, CI/CD |
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

### 4. Strict Code Review (`/review`)
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

## Alternative Setup (Without Plugin)

### Option A: Copy an example
```bash
cp -r examples/solo-project/.claude /your/project/.claude
cp examples/solo-project/CLAUDE.md /your/project/CLAUDE.md
# Edit CLAUDE.md to match your project
```

### Option B: Pick templates
```bash
mkdir -p /your/project/.claude/{agents,skills,learnings}
cp templates/agents/code-reviewer.md /your/project/.claude/agents/
cp -r templates/skills/ship /your/project/.claude/skills/
cp -r templates/skills/retro /your/project/.claude/skills/
```

## Customization

### Swap agent personalities
- Backend: DHH → Rob Pike (Go) → José Valim (Elixir)
- Frontend: Dan Abramov → Evan You (Vue) → Rich Harris (Svelte)
- Reviewer: Linus Torvalds → your tech lead's style

### Adapt to your stack
Each agent has a "Tech Stack" section — update it for your project.

### Add your Git platform
Skills use generic `git` commands. Adapt for:
- **GitHub**: `gh pr create/merge/review`
- **GitLab**: `glab mr create/merge`
- **Gitea**: `tea pr create/merge`

## License

MIT
