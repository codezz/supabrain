# Remember Structure Guide

Detailed breakdown of every folder and when to use it.

## Directory Tree

```
remember/
│
├── Inbox/                          # Temporary capture zone
│   └── *.md                        # Unprocessed notes (clear daily)
│
├── Projects/                       # Active work with deadlines
│   └── <project-name>/
│       ├── <project-name>.md      # Project overview & status
│       ├── meetings/              # Meeting notes
│       └── *.md                   # Project-specific notes
│
├── Areas/                          # Ongoing responsibilities (FLAT)
│   ├── career.md                  # Professional development
│   ├── health.md                  # Fitness, wellbeing, routines
│   ├── family.md                  # Relationships, quality time, dates
│   ├── finances.md                # Budget, investments, income
│   └── <custom-area>.md           # User-created areas
│
├── Notes/                          # Atomic knowledge (Zettelkasten)
│   └── <note-name>.md             # One idea per note
│
├── Resources/                      # External references
│   ├── articles/                  # Saved articles
│   ├── books/                     # Book notes
│   ├── tools/                     # Tool documentation
│   └── *.md                       # General resources
│
├── Journal/                        # Daily notes
│   └── YYYY-MM-DD.md              # One file per day
│
├── People/                         # Relationship tracking
│   └── <firstname-lastname>.md    # One file per person
│
├── Tasks/                          # Task management
│   └── tasks.md                   # All tasks, linked to projects
│
└── Archive/                        # Completed/inactive items
    └── *.md                       # Archived projects/notes
```

## Areas — Design Principles

**Areas are FLAT.** Each area is a single `.md` file, not a folder with sub-files.

### Why flat?

1. **No index pages** — Index pages become either empty or duplicate content
2. **No empty sub-files** — Sub-files like `habits.md` or `learning.md` stay empty forever
3. **No confusion** — You always know where to put something (one file per domain)
4. **Easy to scan** — Open `Areas/` and see 4 files, not nested folders

### Rules

1. **One file per area** — no sub-files, no sub-folders
2. **If a section grows too big** → extract to a Note in `Notes/` and link to it
3. **If an area becomes time-bound** → it's a Project, move it to `Projects/`
4. **Keep each area file under ~200 lines** — if longer, extract sections to Notes

### Default Areas (created at init)

| Area | What goes here | What does NOT go here |
|------|---------------|----------------------|
| `career.md` | Roles, goals, skills, results, positioning | Personal routines, family plans |
| `health.md` | Exercise, nutrition, routines, wellbeing | Career skills |
| `family.md` | Relationships, quality time, dates, vacations | Work schedules |
| `finances.md` | Budget, investments, income streams | Project costs (→ Projects/) |

### Creating custom areas

Users can create additional areas as single files:
```
Areas/side-projects.md
Areas/spirituality.md
Areas/volunteering.md
```

**When to create an area:**
- Ongoing responsibility with no end date
- Regular attention needed
- Not a project (no specific deliverable)

**When NOT to create an area:**
- If it has a deadline → it's a Project
- If it's a one-time note → it's a Note
- If it only has 2-3 lines → add as a section in an existing area

## Folder Details

### Inbox/

**Purpose:** Quick capture without friction. Brain dump zone.

**Rules:**
- Anything goes here first
- No organization required
- Clear DAILY during evening processing
- If something sits >3 days, either process or delete

---

### Projects/

**Purpose:** Active work with specific outcomes and deadlines.

**Rules:**
- Each project gets its own folder
- Must have a main `.md` with overview
- Move to Archive/ when complete
- Link to relevant People/ and Notes/

**When to create a project:**
- Has a clear deliverable
- Has a deadline (even if fuzzy)
- Requires multiple actions
- Will eventually be "done"

---

### Notes/

**Purpose:** Permanent atomic knowledge. Zettelkasten-style.

**Rules:**
- One idea per note
- Heavily linked with `[[wikilinks]]`
- Evergreen — update as knowledge grows
- Not project-specific (that goes in Projects/)

**Good for:**
- Concepts and mental models
- Lessons learned
- Frameworks and methodologies
- Insights that apply broadly

---

### Resources/

**Purpose:** External content worth saving.

**Rules:**
- Always include source URL
- Add why it's valuable
- Summarize key points

---

### Journal/

**Purpose:** Daily chronological record.

**Rules:**
- One file per day: `YYYY-MM-DD.md`
- Created during evening processing
- Links to what was captured/processed

---

### People/

**Purpose:** Track relationships and interactions.

**Rules:**
- One file per person: `firstname-lastname.md`
- Record how you met, context
- Log significant interactions
- Link to shared projects

---

### Tasks/

**Purpose:** Centralized task tracking.

**Rules:**
- Main file: `tasks.md`
- Tasks linked to projects where relevant
- Use `- [ ]` checkbox format
- Review weekly

---

### Archive/

**Purpose:** Completed or inactive items.

**Rules:**
- Move completed projects here
- Maintains history without clutter

## Decision Tree

```
New information arrives
│
├─ Is it about an active project?
│  YES → Projects/<project>/
│
├─ Is it about a person?
│  YES → People/<person>.md
│
├─ Is it about career/professional development?
│  YES → Areas/career.md
│
├─ Is it about health/fitness/routines?
│  YES → Areas/health.md
│
├─ Is it about family/relationships?
│  YES → Areas/family.md
│
├─ Is it about money/budget/investments?
│  YES → Areas/finances.md
│
├─ Is it a task/todo?
│  YES → Tasks/tasks.md (+ project link if relevant)
│
├─ Is it external content (article, link)?
│  YES → Resources/
│
├─ Is it reusable knowledge (concept, lesson)?
│  YES → Notes/
│
├─ Is it a daily reflection?
│  YES → Journal/YYYY-MM-DD.md
│
└─ Not sure?
   → Inbox/ (process later)
```
