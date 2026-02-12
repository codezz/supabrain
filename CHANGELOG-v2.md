# v2 Update — AI-Driven Pattern Detection

## What Changed

**Original approach (v1):**
- ❌ Regex keyword matching în Python scripts
- ❌ Fragil pentru multiple limbi
- ❌ Miss nuances și context

**New approach (v2):**
- ✅ **AI does ALL pattern detection** — semantic understanding
- ✅ **Multi-language support** — înțelege română, engleză, mixed
- ✅ **Context-aware** — nu doar keywords, ci intent
- ✅ Scripts doar pentru I/O — citit/scris fișiere, formatare

---

## Files Changed

### Skills (AI Instructions)

**`skills/process/SKILL.md` — Persona section:**
- AI analyzes sessions semantically (no regex)
- Questions to ask: "Did user correct me?", "What do they prefer?"
- Multi-language examples: "prefer" = "preferă" = "mai bine cu"
- Evidence format + update rules

**`skills/process/SKILL.md` — Task section:**
- AI classifies urgency by understanding context
- Multi-language urgency signals
- Semantic understanding: "de mâine" = urgent, "eventual" = backlog
- Edge cases + linking rules

### Scripts (Simplified)

**`scripts/persona_utils.py`** (replaces persona_learner.py):
- Read Persona.md structure
- Add evidence lines (no pattern detection)
- Update frontmatter dates
- AI decides WHAT to add, script handles HOW

**`scripts/task_utils.py`** (replaces task_router.py):
- Format task markdown
- Get destination info
- No classification logic (AI does that)

### Removed

- ❌ `scripts/persona_learner.py` — regex-based pattern detection
- ❌ `scripts/task_router.py` — keyword-based classification

---

## Why This Is Better

### 1. Multi-Language Support

**Old:**
```python
if re.search(r"\burgent\b", text):  # Miss "urgent", "asap", "de mâine"
```

**New:**
```markdown
AI understands urgency across languages:
- "urgent" = "urgent" = "de mâine" = "asap"
- Semantic intent, not string matching
```

### 2. Context Understanding

**Old:**
```python
if "prefer" in text:  # False positive: "I don't prefer X"
```

**New:**
```markdown
AI reads full context:
- "I prefer X" → positive preference
- "I don't prefer X" → negative signal
- Irony, sarcasm, nuance → understood
```

### 3. Flexibility

**Old:** Add new language → update 50+ regex patterns

**New:** AI already understands — no code changes needed

---

## Usage Example

**Session excerpt:**
```
User: "trebuie să deploy până mâine, e urgent. nu mai folosi acel approach cu regex, prefer AI semantic understanding"
```

**AI Analysis:**

**Task classification:**
- Urgency: URGENT ("până mâine" = deadline tomorrow)
- Destination: tasks.md (Focus)
- Format: `- [ ] Deploy până mâine ⚡ (2026-02-12)`

**Persona update:**
- Correction detected: User rejected regex approach
- Preference: AI semantic understanding over keyword matching
- Evidence: `[2026-02-12] User corrected approach — prefers AI semantic understanding over regex patterns`

**Script calls (by AI):**
```bash
# Format task
python3 scripts/task_utils.py --format "Deploy până mâine" --urgency urgent --date 2026-02-12

# Add persona evidence
echo "User corrected approach — prefers AI semantic understanding over regex" | \
python3 scripts/persona_utils.py --add-evidence-stdin "2026-02-12" ~/remember/Persona.md
```

---

## Migration

No breaking changes. Existing brains work as-is.

Scripts renamed:
- `persona_learner.py` → `persona_utils.py` (simplified)
- `task_router.py` → `task_utils.py` (simplified)

---

**Bottom line:** AI face munca grea (semantic understanding), script-urile doar helper-e simple. 🫡
