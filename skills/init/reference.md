# Init Skill — Reference

Templates and merge rules for `/remember:init`.

---

## Settings Merge Rules

- `env`: add/update `REMEMBER_BRAIN_PATH` key, keep other env vars
- `permissions.additionalDirectories`: append brain path if not present, keep existing
- `permissions.allow`: append rules if not present, keep existing
- All other keys: preserve unchanged

Write merged JSON back to settings file.

---

## Persona.md Template

```markdown
---
updated: {{date}}
tags: [persona, system]
---

# Persona

Best practices for working with {{name}}. Loaded at every session start. Updated by `/remember:process`.

---

## Identity

- **Name:** {{name}}
- **Timezone:** {{timezone}}
- **Languages:** {{languages}}

## Communication

_Patterns will be added as the AI learns your preferences._

## Workflow

_Patterns will be added as the AI learns your work style._

## Decision-Making

_Patterns will be added as the AI learns your decision patterns._

## Code Style

_Patterns will be added as the AI learns your coding preferences._

---

## Evidence Log

_Patterns observed across sessions. Newest first._
```

---

## Tasks File Template

```markdown
---
created: {{date}}
tags: [tasks, overview]
---

# Tasks Overview

Central hub for all tasks.
```

---

## Project Template (Templates/project.md)

```markdown
---
created: {{date}}
status: active
tags: [project]
related: []
---

# {{name}}

## Overview

## Goals
- [ ] Goal 1

## Log
### {{date}}
- Created project
```

---

## Person Template (Templates/person.md)

```markdown
---
created: {{date}}
tags: [person]
---

# {{name}}

## Who
- **Role:**
- **Relationship:**

## Interactions

### {{date}}
- [First interaction]
```

---

## .gitignore Template

```
.DS_Store
.tmp/
```
