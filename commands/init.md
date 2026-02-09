---
name: brain:init
description: Initialize Remember structure and configuration
---

# /brain:init - Initialize Remember

Creates the Remember directory structure and sets up your Second Brain.

## Usage

```
/brain:init
```

## What it does

### 1. Ask for Path

**Prompt user:**
```
Where should I create your Second Brain?

Default: ~/remember
Custom: Enter full path (e.g., ~/Documents/my-brain)
```

If user presses Enter → use default `~/remember`
If user enters path → validate and use custom path

**Validate path:**
- Expand `~` to home directory
- Check if writable
- If exists, ask to confirm or choose different path

### 1b. Update Config

Write chosen path to `~/.claude/plugins/remember/config.json`:

```json
{
  "paths": {
    "data_root": "/chosen/path"
  }
}
```

This ensures all future commands use the same path.

### 2. Create Directory Structure

```bash
mkdir -p {chosen_path}/
├── content/
│   ├── Inbox/
│   ├── Projects/
│   ├── People/
│   ├── Areas/
│   ├── Notes/
│   ├── Resources/
│   ├── Journal/
│   ├── Tasks/
│   ├── Archive/
│   └── Templates/
│       ├── project.md
│       ├── person.md
│       ├── area.md
│       ├── note.md
│       └── journal.md
├── learning/
│   ├── observations/
│   │   ├── current.jsonl
│   │   └── archive/
│   ├── instincts/
│   │   ├── personal/
│   │   │   ├── code-style/
│   │   │   ├── workflow/
│   │   │   ├── communication/
│   │   │   └── decision-making/
│   │   └── inherited/
│   ├── evolved/
│   │   ├── skills/
│   │   ├── agents/
│   │   └── commands/
│   └── meta/
│       ├── identity.json
│       ├── stats.json
│       └── clustering-flags.json
└── README.md
```

### 3. Create Default Areas

Areas are **flat files** — one file per area, no sub-folders, no index pages.

Create these 4 default area files in `content/Areas/`:

**`content/Areas/career.md`:**
```yaml
---
created: {{date}}
tags: [area, career]
related: []
---

# Career

Professional development, skills, and long-term positioning.

## Current Role

- [Your role and company]

## Goals

- [Current professional goals]

## Skills to Develop

- [ ] [Skill 1]
- [ ] [Skill 2]

## Log

```

**`content/Areas/health.md`:**
```yaml
---
created: {{date}}
tags: [area, health]
related: []
---

# Health

Fitness, nutrition, physical and mental wellbeing.

## Routines

- [Exercise schedule, habits]

## Goals

- [Health goals]

## Log

```

**`content/Areas/family.md`:**
```yaml
---
created: {{date}}
tags: [area, family]
related: []
---

# Family

Relationships, quality time, and important dates.

## People

| Who | Relationship | Notes |
|-----|-------------|-------|
| [Name] | [Relationship] | |

## Important Dates

| Person | Date | Notes |
|--------|------|-------|
| [Name] | [Date] | |

## Log

```

**`content/Areas/finances.md`:**
```yaml
---
created: {{date}}
tags: [area, finances]
related: []
---

# Finances

Budget, investments, income, and financial planning.

## Income Streams

- [Source 1]

## Goals

- [Financial goals]

## Log

```

### 4. Create Identity

Ask user questions to create `identity.json`:

**Questions:**
1. What's your name? (default: User)
2. Technical level? (technical / semi-technical / non-technical / chaotic)
3. Preferred language? (English / other)

**Create `learning/meta/identity.json`:**
```json
{
  "name": "User",
  "technical_level": "technical",
  "language": "English",
  "sessions_count": 0,
  "first_session": "{{date}}",
  "last_session": "{{date}}",
  "clustering_flags": {}
}
```

### 5. Create Templates

**`content/Templates/project.md`:**
```yaml
---
created: {{date}}
status: active
tags: [project]
---

# {{name}}

## Overview
[Project description]

## Status
- **Created:** {{date}}
- **Status:** Active

## Recent Activity

## People
- [[People/name|Name]] - Role

## Related
- [[Areas/career|Career]]
```

**`content/Templates/person.md`:**
```yaml
---
created: {{date}}
tags: [person]
---

# {{name}}

## Who
- **Role:** [What they do]
- **Relationship:** [How you know them]

## Interactions

### {{date}}
[First interaction]

## Related
- [[Projects/project|Project]]
```

**`content/Templates/area.md`:**
```yaml
---
created: {{date}}
tags: [area]
related: []
---

# {{title}}

[What this area covers]

## Goals

- [Current goals for this area]

## Log

```

**`content/Templates/note.md`:**
```yaml
---
created: {{date}}
tags: [note]
related: []
---

# {{title}}

[Content]
```

**`content/Templates/journal.md`:**
```yaml
---
date: {{date}}
tags: [journal]
---

# {{date}}

## Sessions

### Session 1 (HH:MM)
**Project:** [[Projects/project|Project]]

**Activity:**
- [What was done]

**People:**
- [[People/name|Name]] - [Context]

**Decisions:**
- [Decision made]

## Captures
- [[Inbox/item|Item]]

## Insights
[Reflections]
```

### 6. Initialize Git (Optional)

Ask: "Initialize git repository?"

If yes:
```bash
cd {chosen_path}
git init
git add .
git commit -m "feat: initialize Remember"
```

Create `.gitignore`:
```
learning/observations/current.jsonl
learning/observations/archive/
.DS_Store
```

### 7. Create README

**`README.md`:**
```markdown
# Remember

Your extended Second Brain that learns as you work in Claude Code.

## What is this?

A hybrid PARA + Zettelkasten system with automatic population and pattern learning.

## Structure

- `content/` - Your Second Brain (Projects, People, Areas, Notes, Journal)
- `learning/` - Meta-learning (observations, instincts, evolved skills)

## Areas

Areas are flat files — one file per life/work domain:
- `Areas/career.md` — Professional development
- `Areas/health.md` — Fitness, wellbeing
- `Areas/family.md` — Relationships, quality time
- `Areas/finances.md` — Budget, investments

## Usage

Work normally in Claude Code. Remember:
- Auto-populates Projects/, People/, Journal/
- Learns your workflow patterns
- Evolves into optimized skills

## Commands

- `/brain:status` - View learning stats
- `/brain:evolve` - Trigger evolution when ready
- `/brain:export` - Share learned patterns
- `/brain:import` - Adopt patterns from others

---

Created: {{date}}
Plugin: remember v1.0.0
```

### 8. Confirm Success

Return message:
```
Remember initialized at {chosen_path}/

Structure created:
- content/ (Second Brain)
- learning/ (Meta-learning)
- Areas: career, health, family, finances
- Templates ready
- Identity configured

Next: Just work in Claude Code!
The brain-curator will maintain your Second Brain automatically.

Commands:
- /brain:status - Check stats
- /brain:evolve - Evolve patterns (when 5+ cluster)
```

## Error Handling

- If path already exists: ask to confirm overwrite or skip
- If custom path not writable: suggest alternative
- If templates fail: create minimal versions

## Notes

- Only needs to run **once** ever (unless resetting)
- Can re-run to add missing folders
- Safe to run multiple times (won't delete existing content)
