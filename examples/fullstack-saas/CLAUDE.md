# CLAUDE.md

Multi-repo SaaS project — manages development workflow, deployment, and automation.

- **Mode**: Kanban (ship from main)
- **Tech Stack**: Next.js 15 / React 19 / Django 5.1 / PostgreSQL / AWS ECS
- **Environments**: alpha → beta → production

## Git Workflow (Most Important)

**Never push directly to main. All changes go through branch → PR.**

- `feature/` / `fix/` / `chore/` → triggers corresponding skill (create-feature / create-fix / create-chore)
- Tag format: `{env}_{YYYYMMDD}_v{major}.{minor}.{patch}_{description}`

## Skills & Agents

Automation is powered by Skills (`.claude/skills/`) and Sub-Agents (`.claude/agents/`).
**When a matching skill exists, always trigger it — never run commands manually.**

| Category | Skills |
|----------|--------|
| **PR Workflow** | pr-create, pr-review, pr-merge |
| **Branching** | create-feature, create-fix, create-chore |
| **Pipeline** | ship (end-to-end), retro (retrospective) |
| **Maintenance** | self-improve |

| Agent | Personality | Role |
|-------|-------------|------|
| **project-manager** | Steve Jobs | Task breakdown + product review |
| **code-reviewer** | Linus Torvalds | PR review + merge (independent from code author) |
| **backend-dev** | DHH | Python/Django backend |
| **frontend-dev** | Dan Abramov | React/Next.js frontend |
| **devops** | Kelsey Hightower | Deployment, AWS, CI/CD |
