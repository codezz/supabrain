# 🧠 BrainRepo

**Your personal knowledge repository — capture, organize, and retrieve everything.**

A dead-simple Second Brain system using PARA + Zettelkasten. Just markdown files in a Git repo. Works with Obsidian, any AI agent, or plain text editors.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Made for Obsidian](https://img.shields.io/badge/Made%20for-Obsidian-7C3AED)](https://obsidian.md)
[![AI Ready](https://img.shields.io/badge/AI-Ready-00D4AA)](https://github.com/codezz/brainrepo)

## ✨ Features

- **📥 Quick Capture** — Dump thoughts instantly, organize later
- **📁 PARA Structure** — Projects, Areas, Notes, Resources, Archive
- **🔗 Zettelkasten Links** — Connect ideas with `[[wiki-links]]`
- **👥 People Tracking** — One note per person, track relationships
- **📅 Daily Journal** — Automatic date-based notes
- **✅ Task Management** — Centralized tasks linked to projects
- **🤖 AI-Native** — Works with Claude Code, OpenClaw, Cursor, ChatGPT
- **📱 Multi-Platform** — Obsidian, VS Code, any markdown editor
- **🔒 Privacy-First** — Your files, your repo, your control

## 🚀 Quick Start

### Option 1: Clone as Your Brain

```bash
git clone https://github.com/codezz/brainrepo.git my-second-brain
cd my-second-brain
rm -rf .git && git init  # Start fresh history
```

### Option 2: Add as AI Skill

**Claude Code:**
```bash
# Add to .claude/skills/
git clone https://github.com/codezz/brainrepo.git .claude/skills/brainrepo
```

**OpenClaw:**
```bash
# Add to skills/
git clone https://github.com/codezz/brainrepo.git ~/.openclaw/workspace/skills/brainrepo
```

### Option 3: Just Copy the Structure

Copy the folder structure and start using it manually.

## 📂 Structure

```
brainrepo/
├── Inbox/          # 📥 Quick capture (process daily)
├── Projects/       # 🎯 Active work with deadlines
│   └── project-name/
│       └── index.md
├── Areas/          # 🔄 Ongoing responsibilities
│   ├── personal-growth/
│   └── family/
├── Notes/          # 💡 Permanent atomic knowledge
├── Resources/      # 📚 External links & references
├── Journal/        # 📅 Daily notes (YYYY-MM-DD.md)
├── People/         # 👥 One note per person
├── Tasks/          # ✅ Centralized task tracking
│   └── index.md
└── Archive/        # 📦 Completed projects
```

## 💡 How It Works

### 1. Capture (Anytime)
Don't think, just dump to `Inbox/`:
```
"Save this: Had an idea about improving onboarding flow"
```

### 2. Process (Evening, 5-10 min)
Move each Inbox item to its permanent home:
- Idea about a project? → `Projects/`
- Reusable knowledge? → `Notes/`
- About a person? → `People/`
- External resource? → `Resources/`
- Just journaling? → `Journal/`

### 3. Retrieve (Anytime)
Ask your AI:
```
"What do I know about [topic]?"
"Find notes related to [project]"
"What did I capture last week?"
```

## 📝 Note Format

```markdown
---
created: 2026-02-04
tags: [tag1, tag2]
related: ["[[Other Note]]"]
---

# Note Title

Your content here. Link to [[Related Notes]] freely.

## Sections as needed

More content.
```

## 🔄 Daily Workflow

| When | What | Time |
|------|------|------|
| **During day** | Dump everything to Inbox/ | Seconds |
| **Evening** | Process Inbox → permanent homes | 5-10 min |
| **End of day** | Update Journal/, commit & push | 2 min |

## 📆 Weekly Review (Sunday)

1. ✅ Review Projects — still active?
2. 📊 Check Areas — anything neglected?
3. 📦 Archive completed projects
4. 🔍 Review Tasks — update priorities
5. 💾 Commit: `git commit -am "weekly review"`

## 🤖 AI Commands

| Command | Action |
|---------|--------|
| "Save this: [text]" | Quick capture to Inbox |
| "New project: [name]" | Create project folder |
| "Add person: [name]" | Create person note |
| "Daily review" | Process Inbox, update Journal |
| "Weekly review" | Full system review |
| "What do I know about X?" | Search & retrieve |

## 🔗 Linking Examples

```markdown
# In a project note
Working with [[People/john-doe]] on this.
See [[Notes/api-design-patterns]] for reference.

# In a person note
Met at [[Projects/acme-launch/index|ACME Launch]].
Interested in [[Notes/machine-learning]].
```

## 📱 Integrations

| Tool | Setup |
|------|-------|
| **Obsidian** | Open folder as vault |
| **VS Code** | Open folder, use Markdown Preview |
| **Claude Code** | Clone to `.claude/skills/` |
| **OpenClaw** | Clone to `skills/` directory |
| **Mobile** | Sync via iCloud/Dropbox + Obsidian Mobile |

## 🏷️ Recommended Tags

```
#project #area #person #meeting #decision #idea 
#learning #resource #task #review #archived
```

## 🆚 Projects vs Areas

| Projects | Areas |
|----------|-------|
| Have deadlines | Ongoing forever |
| Can be completed | Maintained, never "done" |
| Specific deliverable | Standard to uphold |
| `Projects/launch-app/` | `Areas/health/` |

## 📄 License

MIT License — use it however you want.

## 🙏 Credits

Inspired by:
- [PARA Method](https://fortelabs.com/blog/para/) by Tiago Forte
- [Zettelkasten](https://zettelkasten.de/) method
- [Building a Second Brain](https://www.buildingasecondbrain.com/)

---

**Made with 🧠 by [codezz](https://github.com/codezz)**

*Star ⭐ this repo if it helps you think better!*
