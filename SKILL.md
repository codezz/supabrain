---
name: brainrepo
description: >
  Your personal knowledge repository — capture, organize, and retrieve everything using PARA + Zettelkasten.
  Triggers on: "save this", "remember", "note", "capture", "brain dump", "salvează", "notează", daily/weekly
  reviews, searching stored knowledge, managing projects/areas/people. Works with any AI agent that reads
  markdown. Stores everything as .md files in a Git repo for Obsidian, VS Code, or any editor.
---

# BrainRepo

Your personal knowledge repository. Capture fast, organize automatically, retrieve instantly.

## Quick Start

```bash
# Clone the structure into your vault
git clone https://github.com/codezz/brainrepo.git my-brain
cd my-brain
```

Then tell your AI: "Set up brainrepo for me" or just start dumping: "Save this: [your thought]"

## Core Concept

**DUMP → PROCESS → RETRIEVE**

1. **Dump** — Capture everything to Inbox/ (don't organize yet)
2. **Process** — Evening review: Inbox → permanent home
3. **Retrieve** — Ask AI to find anything

## Repository Structure

```
brainrepo/
├── Inbox/          # Quick capture (clear daily)
├── Projects/       # Active work with deadlines
├── Areas/          # Ongoing responsibilities (no deadline)
├── Notes/          # Permanent atomic knowledge
├── Resources/      # External links, articles, references
├── Journal/        # Daily notes (YYYY-MM-DD.md)
├── People/         # One note per person
├── Tasks/          # Centralized task tracking
└── Archive/        # Completed projects
```

## Capture Rules

### What to Capture (Immediately)

| Type | Destination | Example |
|------|-------------|---------|
| Quick thought | `Inbox/` | "Maybe we should..." |
| Decision made | `Inbox/` or `Notes/` | "Decided to use Next.js" |
| Person info | `People/` | New contact or update |
| Project update | `Projects/<name>/` | Meeting notes, progress |
| Task/Todo | `Tasks/index.md` | "Need to finish X" |
| Link/Article | `Resources/` or `Inbox/` | URL with context |
| Personal growth | `Areas/personal-growth/` | Health, habits, learning |
| Family info | `Areas/family/` | Important dates, notes |

### What NOT to Capture

- Casual chat without information value
- Temporary queries ("what time is it")
- Information you can easily Google

## Note Format

Every note uses this minimal frontmatter:

```markdown
---
created: YYYY-MM-DD
tags: [tag1, tag2]
related: ["[[Other Note]]"]
---

# Title

Content here. Link to [[Related Notes]] freely.
```

## Daily Workflow

### Morning (Optional)
- Check `Tasks/index.md` for today's priorities
- Review yesterday's `Journal/` entry

### During Day
- Dump everything to `Inbox/`
- Don't organize — just capture

### Evening (5-10 min)
Process Inbox/:
1. Each item → permanent home or delete
2. Update `Journal/YYYY-MM-DD.md` with summary
3. `git commit -am "daily processing"`

## Weekly Review (Sunday, 15 min)

1. Review all Projects/ — still active?
2. Check Areas/ — anything neglected?
3. Move completed projects to Archive/
4. Update `Tasks/index.md`

## Commands

Tell your AI:

| Say | Action |
|-----|--------|
| "Save this: [text]" | Capture to Inbox/ |
| "New project: [name]" | Create Projects/name/ |
| "Add person: [name]" | Create People/name.md |
| "What do I know about X?" | Search & retrieve |
| "Daily review" | Process Inbox/, update Journal/ |
| "Weekly review" | Full system review |

## Linking

Use `[[wiki-links]]` to connect notes:

```markdown
Met with [[People/john]] about [[Projects/acme/index|ACME Project]].
Relevant insight: [[Notes/negotiation-tactics]]
```

## Projects vs Areas

| Projects | Areas |
|----------|-------|
| Have deadlines | No end date |
| Can be "done" | Maintained forever |
| Specific outcome | Standard to uphold |
| Examples: Launch app, Write book | Examples: Health, Family, Career |

## File Naming

- Folders: `kebab-case/`
- Files: `kebab-case.md`
- Dates: `YYYY-MM-DD.md`
- People: `firstname-lastname.md`

## Git Workflow

```bash
# Daily
git add -A && git commit -m "daily: $(date +%Y-%m-%d)"
git push

# After major changes
git commit -m "add: project X" 
git commit -m "process: weekly review"
```

## Integration

Works with:
- **Obsidian** — Open folder as vault
- **VS Code** — With Markdown preview
- **Any AI** — Claude Code, OpenClaw, Cursor, etc.
- **Mobile** — iCloud/Dropbox sync + any markdown app

## References

- [Structure Guide](references/structure.md) — Detailed folder breakdown
- [Templates](assets/templates/) — Note templates to copy
- [Workflows](references/workflows.md) — Processing workflows
