# team-pipeline

End-to-end development pipeline with a sub-agent team for Claude Code.

## What It Does

Turns Claude Code into a full development team with specialized agents:

| Agent | Personality | Role |
|-------|-------------|------|
| **project-manager** | Steve Jobs | Product specs, prioritization, final review |
| **backend-dev** | DHH | Backend implementation |
| **frontend-dev** | Dan Abramov | Frontend implementation |
| **code-reviewer** | Linus Torvalds | 8-point code review, merge gatekeeper |
| **qa-tester** | James Whittaker | Testing with Google-level rigor |
| **devops** | Kelsey Hightower | Infrastructure, CI/CD, deployments |
| **tech-writer** | Donald Knuth | Documentation |

## Skills (Slash Commands)

| Command | Description |
|---------|-------------|
| `/ship <task>` | Full pipeline: PM spec → implement → QA → review → merge → retro |
| `/review` | Linus-style 8-point code review with auto-fix loop |
| `/retro` | Retrospective: distill learnings so agents improve over time |
| `/create-branch <type> <name>` | Create feature/fix/chore branch with conventions |
| `/create-pr` | Push and create PR with test results |
| `/self-improve` | Audit workspace config for improvements |

## Self-Improving Agents

The `/retro` skill creates a feedback loop:
1. Reviewers find issues → rules are written to `.claude/learnings/`
2. Agents read their learnings before starting work
3. Agents never repeat documented mistakes

Over time, each pipeline run produces higher quality code.

## Setup After Install

1. Copy `learnings/` templates to your project's `.claude/learnings/` directory
2. Customize agent tech stacks in `agents/*.md` to match your project
3. Update your `CLAUDE.md` to reference the agents and skills

## Customization

- **Swap personalities**: DHH → Rob Pike (Go), Dan Abramov → Evan You (Vue)
- **Change tech stack**: edit the "Tech Stack" section in each agent
- **Adapt Git platform**: skills use generic git — swap to `gh`/`glab`/`tea` commands
- **Add/remove agents**: keep the team small (5-6 is optimal)

## License

MIT
