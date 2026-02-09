# Changelog

All notable changes to Remember will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-02-08

### 🎉 Major Release: Skill → Plugin Transformation

Complete redesign from OpenClaw skill to Claude Code plugin with auto-learning capabilities.

### Added

#### Plugin Infrastructure
- `.claude-plugin/plugin.json` - Claude Code plugin metadata
- `hooks/hooks.json` - PreToolUse, PostToolUse, Stop hooks (100% capture)
- `scripts/capture.sh` - Observation capture handler
- `scripts/on_stop.sh` - Session end handler
- `config.json` - Configurable paths and settings

#### Intelligence Layer
- `agents/brain-curator.md` - Main AI agent for auto-population & learning
  - Auto-populates Projects, People, Areas, Notes, Journal
  - Learns patterns from observations
  - Creates instincts (0.3-0.9 confidence)
  - Detects clustering (5+ → ready to evolve)

#### Skills
- `skills/brain-session/SKILL.md` - Session context loader
  - Loads identity, journal, projects at start
  - Spawns brain-curator in background
  - Provides context-aware greeting

#### Commands
- `/brain:init` - Initialize Remember structure
- `/brain:status` - Show learning stats & clustering
- `/brain:evolve` - Evolve clustered instincts into skills/agents
- `/brain:export` - Export instincts (privacy-safe sharing)
- `/brain:import` - Import instincts from others

#### Features
- **Auto-population** - Second Brain grows automatically as you work
- **Pattern learning** - Observes behavior → creates instincts
- **Evolution** - 5+ instincts cluster → generate skills/agents/notes
- **100% capture** - Hooks are deterministic (not probabilistic)
- **Privacy-first** - Observations local, patterns shareable
- **Configurable** - Set custom data_root path
- **Git-friendly** - Commits content, ignores observations
- **Cross-project** - Learns from ALL Claude sessions
- **Export/Import** - Share patterns with others

### Changed

- **README.md** - Complete rewrite for plugin usage
  - Installation instructions for Claude Code
  - Configuration guide
  - Architecture explanation
  - Examples after 1 week of use
  
- **marketplace-entry.json** - Updated from skill to plugin
  - Type: "skill" → "plugin"
  - Added features, requirements, install instructions

- **.gitignore** - Updated for plugin structure
  - Ignore user data (data/)
  - Ignore observations (*.jsonl)

### Kept

- **SKILL.md** - Preserved for OpenClaw compatibility
  - Users without Claude Code can still use as skill
  - Manual observation (no hooks in OpenClaw)

- **LICENSE** - MIT (unchanged)
- **assets/** - Templates and references (unchanged)
- **references/** - Documentation (unchanged)

### Breaking Changes

⚠️ **Requires Claude Code** - Hooks infrastructure needed for full functionality

⚠️ **Manual setup required** - Must run `/brain:init` after install

⚠️ **Config path** - Users must edit `config.json` to set `data_root`

⚠️ **OpenClaw users** - Can use as skill but without hooks (partial functionality)

### Migration from v0.x

If you used previous version as OpenClaw skill:

1. **Data is safe** - Your existing brain repo unchanged
2. **Install as plugin** - `git clone` to `~/.claude/plugins/`
3. **Set path** - Edit `config.json` to point to your existing brain
4. **Run init** - `/brain:init` (will detect existing structure)
5. **Start working** - Auto-population & learning will begin

### Technical Details

**Architecture:**
- Plugin code: `~/.claude/plugins/remember/`
- User data: `~/remember/` (configurable)
- Clean separation: code ≠ data

**Hooks:**
- PreToolUse: Captures before tool execution
- PostToolUse: Captures after tool execution  
- Stop: Updates stats at session end

**Observer:**
- Model: Haiku (cost-efficient)
- Frequency: Every 5 minutes (configurable)
- Processing: Background (doesn't interrupt work)

**Instincts:**
- Format: YAML frontmatter + Markdown
- Confidence: 0.3 (tentative) → 0.9 (certain)
- Evidence: Journal links + observation timestamps
- Domains: code-style, workflow, communication, decision-making

**Evolution:**
- Threshold: 5+ instincts in domain
- Trigger: Manual (`/brain:evolve`)
- Output: skills/ + agents/ + content/Notes/Meta/
- Preserves: Original instincts (marked as evolved)

### Known Issues

- Hooks require Claude Code restart after install
- Observer frequency not yet runtime-configurable
- Export/import UI could be more interactive

### Future Roadmap

#### v1.1.0 (Planned)
- Auto-evolution (optional, when threshold reached)
- Web UI for browsing brain
- Advanced stats dashboard
- Instinct confidence visualization

#### v2.0.0 (Vision)
- Multi-user brains (team learning)
- Brain merging (combine patterns from multiple sources)
- AI-suggested evolutions (proactive recommendations)
- Integration with external tools (Obsidian sync, etc.)

---

## [0.x] - Before 2026-02-08

Legacy versions as OpenClaw skill. See git history for details.

### Summary of pre-1.0 features:
- Basic PARA structure
- Manual note creation
- Zettelkasten linking
- Daily journal
- Task management
- OpenClaw skill format

**Migration:** Users on v0.x should upgrade to v1.0.0 for auto-learning features.

---

[1.0.0]: https://github.com/codezz/remember/releases/tag/v1.0.0
