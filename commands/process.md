---
name: brain:process
description: Process unprocessed Claude sessions into your Second Brain
---

# /brain:process - Process Sessions into Second Brain

Reads unprocessed Claude Code transcripts and routes valuable content into your Second Brain.

## Usage

```
/brain:process
/brain:process --project impact3
```

## Steps

### 1. Resolve Brain Path

Read `~/.claude/plugins/remember/config.json` → get `paths.data_root`.
Use this as `{brain_path}`. If missing → tell user to run `/brain:init`.

### 2. Find Unprocessed Sessions

Run:
```bash
python3 ${CLAUDE_PLUGIN_ROOT}/scripts/extract.py --unprocessed
```

If `--project` argument was given:
```bash
python3 ${CLAUDE_PLUGIN_ROOT}/scripts/extract.py --unprocessed --project <name>
```

Show the list to the user and ask which sessions to process.
Options:
- **All** — process everything
- **Pick specific sessions** — user selects by number
- **Skip** — cancel

### 3. Extract Each Session

For each selected session, run:
```bash
python3 ${CLAUDE_PLUGIN_ROOT}/scripts/extract.py <transcript_path>
```

This outputs clean markdown with user messages and short assistant responses.

### 4. Read Current Brain Structure

List what exists to avoid duplicates:
```bash
ls {brain_path}/People/
ls {brain_path}/Projects/
ls {brain_path}/Notes/
ls {brain_path}/Journal/
ls {brain_path}/Tasks/tasks.md
```

### 5. Route Content Intelligently

Read the extracted content and route to the appropriate location:

| Content Type | Destination | Action |
|---|---|---|
| People mentioned (not casually) | `{brain_path}/People/{name}.md` | Create or append interaction |
| Tasks / TODOs | `{brain_path}/Tasks/tasks.md` | Append new tasks |
| Project work | `{brain_path}/Projects/{name}/{name}.md` | Update with activity |
| Technical learnings | `{brain_path}/Notes/{topic}.md` | Create or update |
| Daily summary | `{brain_path}/Journal/YYYY-MM-DD.md` | Create or update |
| Decisions | `{brain_path}/Notes/decision-{topic}.md` | Create with context |
| Area-related | `{brain_path}/Areas/{area}.md` | Append to relevant area |

#### Routing Rules

**People** — Only create/update for meaningful interactions:
- Meetings, calls, discussions with named individuals
- NOT for casual mentions or names in code
- Update `last_contact` in frontmatter, append to `## Interactions`

**Projects** — Match to existing projects when possible:
- Check `{brain_path}/Projects/` for existing project folders
- Update recent activity section
- Link to people involved

**Journal** — Group by project, not chronologically:
```markdown
## {Project Name}
- What was done
- Decisions made
- People: [[People/name]]
```

**Notes** — For technical insights, patterns, learnings:
- Use `{brain_path}/Notes/{descriptive-kebab-case}.md`
- Prefix decisions with `decision-`

**Tasks** — Append to `{brain_path}/Tasks/tasks.md`:
```markdown
- [ ] Task description [[Projects/project|Context]]
```

### 6. File Format

All files use YAML frontmatter + wikilinks:

```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [tag1, tag2]
---

# Title

Content with [[wikilinks]].
```

When updating existing files:
- **Read the file first** to match existing style
- **Append** new content, don't replace
- **Update** frontmatter dates

### 7. Mark Sessions as Processed

After successfully routing content from a session:
```bash
python3 ${CLAUDE_PLUGIN_ROOT}/scripts/extract.py --mark-processed <session_id>
```

### 8. Report Results

Show summary:
```
Brain updated from 3 sessions:

Created:
  - People/archie.md (new)
  - Notes/decision-second-brain-architecture.md (new)

Updated:
  - Journal/2026-02-09.md (+2 sections)
  - Projects/impact3/impact3.md (activity update)
  - Tasks/tasks.md (+1 task)

Processed sessions: 3
Remaining unprocessed: 12
```

## What to Capture vs Skip

**Capture:**
- Meaningful conversations about work, people, decisions
- Technical learnings and patterns
- Action items and tasks
- Project progress and status
- Strategic discussions

**Skip:**
- Routine code generation / debugging (too granular)
- Plugin installation and setup sessions
- Sessions that are mostly tool calls with little conversation
- System/meta messages

## Error Handling

- If extract.py fails → show error, skip that session, continue with others
- If a file write fails → warn user, continue with remaining routes
- If no unprocessed sessions → tell user, suggest using "remember this:" for immediate capture
