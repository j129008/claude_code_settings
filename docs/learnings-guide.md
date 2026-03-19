# Learnings Guide — Self-Improving Agents

How the agent self-improvement loop works.

## The Problem

AI agents repeat the same mistakes across conversations. Each session starts from scratch — the agent has no memory of past reviews, bugs found, or process failures.

## The Solution: Learnings Files

`.claude/learnings/` contains per-agent files that accumulate rules from real project experience:

```
.claude/learnings/
├── backend-dev.md      # Backend coding rules
├── frontend-dev.md     # Frontend coding rules
├── devops.md           # Deployment/infra rules
├── qa-tester.md        # Testing blind spots
└── workflow.md         # Process compliance rules
```

Each file follows this format:
```markdown
# Backend Dev Learnings

Rules learned from past code reviews and pipeline runs. Read this before starting backend work.

<!-- Format: - [YYYY-MM-DD] <rule> (source: <reviewer>) -->
- [2026-03-18] All packages in requirements.txt must use exact version pins (==). (source: Linus Torvalds)
- [2026-03-18] Never use mutable default arguments in function signatures. (source: Linus Torvalds)
- [2026-03-19] Pre-processing before API calls must be inside try/except. (source: James Whittaker)
```

## How It Works

### 1. Agents read before working
Every agent definition includes:
```markdown
## Self-Improvement
Before starting any task, read `.claude/learnings/backend-dev.md` for rules learned from past reviews.
These are mistakes you've made before — don't repeat them.
```

### 2. Reviewers write after finding issues
When a code reviewer finds a problem:
```markdown
## Self-Improvement Feedback
When you issue NEEDS WORK, append rules to the relevant learnings file.
Format: `- [YYYY-MM-DD] <concise rule> (source: Linus Torvalds)`
```

### 3. Retro consolidates
The `/retro` skill runs after each pipeline:
- Collects ALL reviewer feedback from the session
- Distills actionable, generalizable rules
- Deduplicates against existing rules
- Appends to the right learnings file

### The Feedback Loop

```
Agent reads learnings → Implements code → Reviewer finds issues
                ↑                                    ↓
         /retro updates ← QA finds bugs ← Code review rejects
```

Over time:
- **Round 1**: Agent makes common mistakes → reviewer catches them
- **Round 5**: Agent avoids documented mistakes → reviewer catches new ones
- **Round 20**: Agent produces consistently higher quality code

## Rules for Writing Good Learnings

### Do
- **Be specific**: `Never use mutable defaults in async handlers` > `Handle defaults carefully`
- **Include context**: when does this rule apply?
- **Attribute source**: which reviewer caught it?
- **Date it**: rules may become outdated as the project evolves
- **One rule per line**: keeps the file scannable

### Don't
- Don't add one-off typo fixes — only generalizable rules
- Don't add rules the framework already enforces (linter, type checker)
- Don't duplicate existing rules — update them instead
- Don't delete rules — they represent real experience (mark as outdated if needed)

## Real Examples

These are actual rules accumulated from a production project:

**Backend (caught by Linus Torvalds):**
```
- [2026-03-18] subprocess.Popen calls that are macOS-only must be wrapped in try/except
- [2026-03-18] Pydantic fields representing structured sub-objects must use typed nested models, not dict
- [2026-03-18] Register static sub-path routes adjacent to siblings, not at file bottom
```

**Frontend (caught by Steve Jobs):**
```
- [2026-03-18] Accordion empty states must never be visually empty — provide an empty state card
- [2026-03-18] Abstract grid pickers require axis context — never render bare NxN grids
- [2026-03-18] Sidebar control order must reflect usage frequency, not feature enumeration
```

**QA (caught by James Whittaker):**
```
- [2026-03-18] When testing dynamic UI slots, verify index variables in closures are still valid after removal
- [2026-03-19] When testing restore/load flows, test against the full data distribution, not just happy path
```

## Getting Started

1. Create empty learnings files for each agent role (use templates from `templates/learnings/`)
2. Add the "Self-Improvement" section to each agent definition
3. Add the `/retro` skill to your project
4. Run your first `/ship` pipeline — learnings will start accumulating naturally

The files will be empty at first. That's fine. After 3-5 pipeline runs, you'll have a meaningful knowledge base that makes each subsequent run smoother.
