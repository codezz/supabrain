# Process Skill — Reference

Detailed routing tables, templates, and classification rules for `/remember:process`.

---

## Classification Table

| Category | What to look for | Destination |
|----------|-----------------|-------------|
| **Decisions** | "We decided...", "Going with...", chose X over Y | `Notes/decision-{topic}.md` |
| **Commitments** | "I'll do X by Friday", promises with owners/deadlines | `Tasks/tasks.md` + link |
| **Tasks** | "Need to...", "TODO", "trebuie să..." | See Task Routing below |
| **Learnings** | "TIL", insights, patterns discovered, "am învățat că..." | `Notes/{topic}.md` |
| **People interactions** | Meetings, calls, discussions with named people | `People/{name}.md` |
| **Project updates** | Work done, progress, status changes | `Projects/{name}/{name}.md` |
| **Area updates** | Health habits, career moves, family events, finances | `Areas/{area}.md` |
| **Resources/URLs** | External links shared | `Resources/{type}/{title}.md` |
| **Behavioral patterns** | Corrections, preferences, repeated workflows | `Persona.md` |

---

## Task Routing

| Urgency | Signals | Destination | Limit |
|---------|---------|-------------|-------|
| **URGENT** | Deadline this week, someone waiting, "asap", "urgent", "de mâine", "azi" | `Tasks/tasks.md` → ## Focus | 10 |
| **IMPORTANT** | Clear action, no deadline, "trebuie să", "need to", "should" | `Tasks/tasks.md` → ## Next Up | 15 |
| **BACKLOG** | Future work, "Phase 2", "eventually", "eventual", "când am timp" | `Projects/{name}/{name}.md` → ## Tasks/Backlog | ∞ |

**Format:** `- [ ] Task description [[Projects/name/name|Name]] [⚡ if urgent] ({SESSION_DATE})`

**Rules:**
- Never duplicate between tasks.md and project files
- Ambiguous → default to IMPORTANT
- Focus full (10) → push to Next Up
- Next Up full (15) → push to Backlog + journal note

---

## Update Patterns (Edit Tool)

### People — Update Interaction Log
```
Read People/{name}.md first.
Edit tool:
  old_string: (last line of ## Interactions section)
  new_string: (that line + new interaction entry)

Also update last_contact in frontmatter:
  old_string: "last_contact: 2026-01-15"
  new_string: "last_contact: {SESSION_DATE}"
```

### Projects — Update Log
```
Read Projects/{name}/{name}.md first.
Find the ## Log section, add entry:
  old_string: "## Log\n"  (or last log entry)
  new_string: "## Log\n\n### {SESSION_DATE}\n- {what was done}\n"
```

### Journal — Append Sections
```
If Journal/{SESSION_DATE}.md exists, read it first.
Use Edit to append new project sections.
If it doesn't exist, use Write (see Templates below).
```

### Tasks — Add to Correct Section
```
Read Tasks/tasks.md first.
Find ## Focus or ## Next Up section.
Use Edit to insert new task after section header.
```

### Areas — Append Content
```
Read Areas/{area}.md. Find relevant section.
Use Edit to append new content to that section.
```

**Always update frontmatter `updated:` field to SESSION_DATE (only if newer than existing).**

---

## Templates (Write Tool — New Files)

### New Person
```markdown
---
created: {SESSION_DATE}
updated: {SESSION_DATE}
tags: [person]
role: {role if known}
organization: {org if known}
last_contact: {SESSION_DATE}
related: []
---

# {Person Name}

{Brief description from session context}

## Who
- **Role:** {role}
- **Context:** {how they came up}

## Notes to Remember
- {key things mentioned}

## Interactions

### {SESSION_DATE}
- {what happened/was discussed}
```

### New Project
```markdown
---
created: {SESSION_DATE}
status: active
tags: [project]
related: []
---

# {Project Name}

## Overview
{from session context}

## Tasks
### Active
- [ ] {tasks from session}

## Log
### {SESSION_DATE}
- Project created from session context
- {details}
```

### New Note
```markdown
---
created: {SESSION_DATE}
updated: {SESSION_DATE}
tags: [{topic-tags}]
related: [{wikilinks to related entities}]
---

# {Topic Title}

{Content — insight, learning, decision rationale}

## Related
- [[Projects/{related}]] — context
- [[People/{related}]] — who was involved
```

### New Journal Entry
```markdown
---
created: {SESSION_DATE}
tags: [journal]
---

# {SESSION_DATE}

## {Project/Topic Name}
- {What happened}
- Discussed with [[People/{name}]]
- Decision: {what was decided}
- See [[Notes/{related-note}]]
```

---

## Date Rules (Critical!)

- **Journal filename:** `Journal/{SESSION_DATE}.md` — NOT today
- **Frontmatter created:** SESSION_DATE (new files)
- **Frontmatter updated:** SESSION_DATE (if newer than existing)
- **People last_contact:** SESSION_DATE
- **Task dates:** SESSION_DATE for traceability
- **Multi-day sessions:** Route content to the day it occurred

---

## Areas Intelligence

| Question | YES → | NO → |
|----------|-------|------|
| Time-bound with deadline? | Project | Continue |
| Ongoing responsibility? | Area | Note (one-off) |

Default areas: `career.md`, `health.md`, `family.md`, `finances.md`
Areas are **flat files** — one `.md` per area, no subfolders.

---

## Resource Capture (URLs)

When session contains URLs:
1. Fetch metadata: `web_fetch(url)` → title, author, summary
2. Classify: article, tool, video, book, docs
3. Create `Resources/{type}/{title}.md` with frontmatter + summary + key takeaways
4. Auto-link to related Projects/Notes
5. If fetch fails → create minimal note with URL, flag for review

---

## Linking Rules

- Use `[[wikilinks]]` everywhere: `[[People/name]]`, `[[Projects/name/name|Display]]`, `[[Notes/topic]]`
- **Link forward only** — Obsidian handles backlinks
- Write actual content in multiple files only when adding real information (not just backlinks)
- In frontmatter: `related: ["[[Notes/topic]]", "[[Projects/name/name]]"]`
