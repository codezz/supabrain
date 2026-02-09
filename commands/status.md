---
name: brain:status
description: Show Remember learning statistics and status
---

# /brain:status - Remember Status

Displays learning statistics, recent activity, and clustering status.

## Usage

```
/brain:status
```

## What it shows

### 0. Resolve Brain Path

Read `~/.claude/plugins/remember/config.json` → get `paths.data_root` value.
Use this as `{brain_path}` below. If config missing → tell user to run `/remember:init`.

### 1. Identity Summary

Read `{brain_path}/System-learnings/meta/identity.json`:

```
🧠 Remember Status

Name: User
Technical Level: technical
Sessions: 42
First Session: 2026-02-01
Last Session: 2026-02-08
```

### 2. Second Brain Statistics

Count entities in brain root:

```
📚 Second Brain Content

Projects: 5 active
  - my-app (last: today)
  - project-a (last: 2 days ago)
  - staxwp (last: 5 days ago)

People: 8 total
  - alice (last contact: today)
  - roxana (last contact: yesterday)

Areas: 2 active
  - development
  - business

Notes: 12 knowledge notes
Journal: 7 days logged
Tasks: 15 open, 8 completed
```

### 3. Learning Statistics

Read `{brain_path}/System-learnings/meta/stats.json`:

```
🧠 Meta-Learning

Observations: 342 total, 50 recent
Instincts: 18 learned
  - code-style: 7 (avg confidence 0.75)
  - workflow: 5 (avg confidence 0.82)
  - communication: 4 (avg confidence 0.68)
  - decision-making: 2 (avg confidence 0.73)

Evolved: 2 skills, 0 agents, 0 commands
```

### 4. Clustering Status

Read `{brain_path}/System-learnings/meta/clustering-flags.json`:

```
🌱 Ready to Evolve

✅ code-style (7 instincts) - READY
⚠️  workflow (5 instincts) - READY
   communication (4 instincts) - needs 1 more
   decision-making (2 instincts) - needs 3 more

Run /brain:evolve to create evolved skills!
```

### 5. Recent Activity (Last 7 Days)

```
📊 Recent Activity

Projects worked on:
- my-app: 15 sessions
- project-a: 8 sessions
- staxwp: 3 sessions

People interacted with:
- alice: 5 interactions
- roxana: 2 interactions

Patterns detected:
- prefer-typescript (confidence ↑ 0.7 → 0.8)
- test-before-commit (confidence ↑ 0.6 → 0.7)
- auto-capture-links (new, confidence 0.5)
```

## Implementation

```javascript
async function brainStatus() {
  const brainRepo = '{brain_path}'; // from ~/.claude/plugins/remember/config.json
  
  // 1. Identity
  const identity = await readJSON(`${brainRepo}/learning/meta/identity.json`);
  
  // 2. Count entities
  const projects = await countFiles(`${brainRepo}/Projects`);
  const people = await countFiles(`${brainRepo}/People`);
  const areas = await countFiles(`${brainRepo}/Areas`);
  const notes = await countFiles(`${brainRepo}/Notes`);
  const journalDays = await countFiles(`${brainRepo}/Journal`);
  
  // 3. Learning stats
  const stats = await readJSON(`${brainRepo}/learning/meta/stats.json`);
  
  // 4. Clustering
  const clustering = await readJSON(`${brainRepo}/learning/meta/clustering-flags.json`);
  
  // 5. Recent activity
  const recentProjects = await findRecentProjects(brainRepo, 7);
  const recentPeople = await findRecentPeople(brainRepo, 7);
  const recentPatterns = await findRecentPatterns(brainRepo, 7);
  
  return formatStatus({
    identity,
    entities: { projects, people, areas, notes, journalDays },
    learning: stats,
    clustering,
    recent: { projects: recentProjects, people: recentPeople, patterns: recentPatterns }
  });
}
```

## Optional: Detailed View

Add `--detailed` flag for more info:

```
/brain:status --detailed
```

Shows:
- Full list of projects with last active dates
- Full list of people with interaction counts
- All instincts with confidence scores
- Observation processing statistics
- Git commit history (if enabled)

## Notes

- Fast command (just reads metadata, doesn't process)
- Can run anytime
- Useful for daily check-in
