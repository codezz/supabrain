---
name: brain:evolve
description: Evolve clustered instincts into skills, agents, or knowledge notes
---

# /brain:evolve - Evolve Instincts

Triggers manual evolution when 5+ instincts cluster in a domain.

## Usage

```
/brain:evolve
```

Or specific domain:
```
/brain:evolve code-style
```

## What it does

### 1. Check Clustering

Read `~/brainrepo/learning/meta/clustering-flags.json`:

```json
{
  "code-style": 7,
  "workflow": 5,
  "communication": 4,
  "decision-making": 2
}
```

Identify domains with 5+ instincts (ready to evolve).

### 2. Show Available Clusters

If no domain specified, list options:

```
🌱 Ready to Evolve

Available clusters:

1. code-style (7 instincts, avg confidence 0.75)
   - prefer-typescript
   - functional-components
   - strict-mode
   - no-any
   - named-exports
   - arrow-functions
   - destructuring

2. workflow (5 instincts, avg confidence 0.82)
   - test-before-commit
   - commit-granular
   - auto-capture-links
   - daily-review
   - weekly-planning

Which domain to evolve? (1, 2, or 'all')
```

### 3. Load Instincts

For selected domain, read all instincts:

```javascript
const instincts = await loadInstincts(`~/brainrepo/learning/instincts/personal/${domain}/`);

// Sort by confidence
instincts.sort((a, b) => b.confidence - a.confidence);
```

### 4. Synthesize Knowledge

Use synthesizer agent or local LLM to analyze:

**Input:**
- All instinct content
- Evidence from journal entries
- Related projects/people
- Confidence scores

**Analysis:**
- Common patterns
- Core principles
- Contradictions (if any)
- Context (when applicable)

### 5. Decide Evolution Type

Based on analysis:

```javascript
if (domain === 'code-style' || domain === 'testing') {
  type = 'skill'; // Auto-triggered behavior
} else if (domain === 'workflow' && userInvoked) {
  type = 'command'; // User-invoked action
} else if (domain === 'communication' || complexity > threshold) {
  type = 'agent'; // Needs isolation/depth
}
```

### 6. Generate Evolution

#### If type = 'skill':

Create `~/brainrepo/learning/evolved/skills/{domain}-skill/`

**SKILL.md:**
```yaml
---
name: {domain}-skill
description: Evolved from {count} instincts
version: 1.0.0
source: evolved
confidence: {avg_confidence}
instincts:
  - learning/instincts/personal/{domain}/{instinct1}.md
  - learning/instincts/personal/{domain}/{instinct2}.md
  ...
---

# {Domain} Skill

[Synthesized description of what this skill does]

## When to use

[Triggers based on instinct triggers]

## What it does

[Actions based on instinct actions]

## Evidence

Based on {count} observations across {days} days:
[List key evidence from instincts]

## Related Content

- [[Projects/...]]
- [[Notes/...]]
```

#### If type = 'agent':

Create `~/brainrepo/learning/evolved/agents/{domain}-agent.md`

Similar structure but designed for spawning as specialist agent.

#### If type = 'command':

Create `~/brainrepo/learning/evolved/commands/{domain}-command.md`

Command format for user invocation.

### 7. Create Knowledge Note (Always)

In addition to executable artifact, create knowledge doc:

`~/brainrepo/content/Notes/Meta/{domain}-patterns.md`

```yaml
---
created: {date}
tags: [meta, evolved, {domain}]
confidence: {avg_confidence}
source: evolved-from-instincts
instincts: [...]
---

# My {Domain} Patterns (Evolved Knowledge)

[Comprehensive synthesis of all instinct knowledge]

## Core Principles

[Distilled wisdom from instincts]

## Evidence

[Cross-referenced journal entries and projects]

## Evolution

This knowledge emerged from {count} observed patterns over {days} days.

## Source Instincts

- [[learning/instincts/personal/{domain}/{instinct1}|{Instinct 1}]]
- [[learning/instincts/personal/{domain}/{instinct2}|{Instinct 2}]]
...
```

### 8. Update Metadata

- Clear clustering flag for evolved domain
- Update stats.json with evolution count
- Mark instincts as "evolved" (don't delete, keep as evidence)

### 9. Commit (if enabled)

```bash
cd ~/brainrepo
git add learning/evolved/ content/Notes/Meta/
git commit -m "evolution: {domain} cluster evolved (${count} instincts)"
git push  # if remote configured
```

### 10. Confirm Success

```
✅ Evolution Complete: {domain}

Created:
- learning/evolved/skills/{domain}-skill/
- content/Notes/Meta/{domain}-patterns.md

This skill will now activate automatically based on learned patterns.

Summary:
- {count} instincts synthesized
- Average confidence: {avg_confidence}
- Evidence: {evidence_count} journal entries, {project_count} projects

View evolved skill: learning/evolved/skills/{domain}-skill/SKILL.md
View knowledge: [[Notes/Meta/{domain}-patterns]]
```

## Example Evolution

**Input: 7 code-style instincts**
- prefer-typescript (0.8)
- functional-components (0.75)
- strict-mode (0.82)
- no-any (0.73)
- named-exports (0.71)
- arrow-functions (0.76)
- destructuring (0.69)

**Output:**

1. **Skill:** `learning/evolved/skills/my-code-style/`
   - Activates when writing code
   - Suggests TypeScript, functional, strict patterns
   
2. **Knowledge:** `content/Notes/Meta/my-code-philosophy.md`
   - Documents your coding philosophy
   - Links to all evidence
   - Explains reasoning

## Options

```bash
/brain:evolve --preview         # Show what would be created (don't actually evolve)
/brain:evolve code-style --force   # Force evolution even if <5 instincts
/brain:evolve all              # Evolve all ready clusters
```

## Notes

- Manual trigger (not automatic) - you control when
- Can re-evolve same domain later if new instincts added
- Original instincts preserved (marked as "evolved" but not deleted)
- Evolution is additive (doesn't replace, enhances)
