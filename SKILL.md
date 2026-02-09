---
name: remember
description: >
  Your personal knowledge repository — capture, organize, and retrieve everything using PARA + Zettelkasten.
  Triggers on: "save this", "remember", "note", "capture", "brain dump".
  Process past sessions with /brain:process. Stores everything as .md files in a Git repo for Obsidian.
---

# Remember

Your personal knowledge repository. Two ways to populate it:

1. **Brain Dump** (immediate) — Say "remember this: ..." and content routes to the right place
2. **Process Sessions** (on-demand) — Run `/brain:process` to extract value from past Claude sessions

## Brain Location

Read `~/.claude/plugins/remember/config.json` → `paths.data_root`.
Default: `~/second-brain/`

## First Run Check

**Before any action**, check if brain is initialized:

1. Read config → get brain path
2. Check if path exists with expected structure (Inbox/, Projects/, Areas/)
3. If NOT found → Tell user to run `/brain:init`
4. If found → Proceed

## Repository Structure

```
second-brain/
├── Inbox/          # Quick capture (clear daily)
├── Projects/       # Active work with deadlines
├── Areas/          # Ongoing responsibilities (flat files)
├── Notes/          # Permanent knowledge, learnings, decisions
├── Resources/      # External links, articles, references
├── Journal/        # Daily notes (YYYY-MM-DD.md)
├── People/         # One note per person
├── Tasks/          # Centralized task tracking (tasks.md)
├── Templates/      # Note templates
└── Archive/        # Completed projects
```

## How It Works

### Brain Dump (Immediate Capture)

When user says "remember this", "save this", "brain dump", etc., the `UserPromptSubmit` hook
injects routing context. Claude (current session) then writes directly to the correct location.

The hook runs `scripts/user_prompt.sh` which:
- Detects brain dump keywords
- Lists current brain structure (existing People, Projects, Areas)
- Injects routing rules as additional context

### Process Sessions (On-Demand)

`/brain:process` reads unprocessed Claude Code transcripts from `~/.claude/projects/`.
Uses `scripts/extract.py` to parse JSONL transcripts into clean markdown, then routes content.

See `commands/process.md` for full instructions.

## Routing Rules

| Content | Destination |
|---------|------------|
| Person interaction | `People/{name}.md` |
| Task / TODO | `Tasks/tasks.md` |
| Project work | `Projects/{name}/{name}.md` |
| Technical learning | `Notes/{topic}.md` |
| Decision | `Notes/decision-{topic}.md` |
| Daily summary | `Journal/YYYY-MM-DD.md` |
| Career/professional | `Areas/career.md` |
| Health/fitness | `Areas/health.md` |
| Family | `Areas/family.md` |
| Finances | `Areas/finances.md` |
| Links/articles | `Resources/` |
| Unclear | `Inbox/` |

## Note Format

Every note uses minimal frontmatter:

```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [tag1, tag2]
---

# Title

Content here. Link to [[Related Notes]] freely.
```

## Commands

| Command | Action |
|---------|--------|
| `/brain:init` | Initialize brain structure |
| `/brain:process` | Process unprocessed Claude sessions |
| `/brain:status` | Show brain statistics |
| "remember this: X" | Immediate brain dump |
| "save this: X" | Immediate brain dump |

## File Naming

- Folders: `kebab-case/`
- Files: `kebab-case.md`
- Dates: `YYYY-MM-DD.md`
- People: `firstname.md` or `firstname-lastname.md`

## Linking

Use `[[wiki-links]]` to connect notes:

```markdown
Met with [[People/archie]] about [[Projects/impact3/impact3|Impact3]].
Relevant insight: [[Notes/n8n-workflow-patterns]]
```
