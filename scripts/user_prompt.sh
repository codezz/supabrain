#!/bin/bash
# Remember - User Prompt Hook
# 1. On FIRST message of session → injects Persona context
# 2. On brain dump keywords → injects full processing instructions
# Fires on every UserPromptSubmit.

[ "$REMEMBER_PROCESSING" = "1" ] && exit 0

# Read stdin
INPUT=$(cat)

# Resolve brain path
USER_CONFIG="$HOME/.claude/plugins/remember/config.json"
BRAIN_PATH=""
if [ -f "$USER_CONFIG" ]; then
  BRAIN_PATH=$(grep -o '"data_root": "[^"]*"' "$USER_CONFIG" | cut -d'"' -f4)
fi
BRAIN_PATH="${BRAIN_PATH:-$HOME/second-brain}"
BRAIN_PATH="${BRAIN_PATH/#\~/$HOME}"

[ ! -d "$BRAIN_PATH" ] && exit 0

# --- FIRST MESSAGE: Inject Persona ---
SESSION_FLAG="/tmp/remember-session-${CLAUDE_SESSION_ID:-unknown}"
if [ ! -f "$SESSION_FLAG" ]; then
  touch "$SESSION_FLAG"

  PERSONA=""
  [ -f "$BRAIN_PATH/Persona.md" ] && PERSONA=$(cat "$BRAIN_PATH/Persona.md")

  TODAY=$(date +"%Y-%m-%d")
  JOURNAL=""
  [ -f "$BRAIN_PATH/Journal/$TODAY.md" ] && JOURNAL="Today's journal exists at Journal/$TODAY.md"

  PROJECTS=$(ls -d "$BRAIN_PATH/Projects/"*/ 2>/dev/null | xargs -I{} basename {} | tr '\n' ', ' | sed 's/,$//')

  cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": "REMEMBER BRAIN LOADED. Brain: ${BRAIN_PATH}\n\nPERSONA (apply throughout session):\n${PERSONA}\n\nCONTEXT: ${JOURNAL}. Active projects: ${PROJECTS:-none}.\n\nCommands: /brain:process, 'remember this: ...'"
  }
}
EOF
  exit 0
fi

# --- SUBSEQUENT: Check for brain dump keywords ---
LOWER_INPUT=$(echo "$INPUT" | tr '[:upper:]' '[:lower:]')

BRAIN_DUMP=false
for keyword in "save this" "remember this" "brain dump" "note to self" "capture this" "save to brain" "write to brain" "add to brain" "salvează" "notează" "reține"; do
  if echo "$LOWER_INPUT" | grep -qF "$keyword"; then
    BRAIN_DUMP=true
    break
  fi
done

[ "$BRAIN_DUMP" = false ] && exit 0

# --- BRAIN DUMP: Full processing instructions ---
PEOPLE=$(ls "$BRAIN_PATH/People/" 2>/dev/null | sed 's/\.md$//' | tr '\n' ', ' | sed 's/,$//')
PROJECTS=$(ls -d "$BRAIN_PATH/Projects/"*/ 2>/dev/null | xargs -I{} basename {} | tr '\n' ', ' | sed 's/,$//')
AREAS=$(ls "$BRAIN_PATH/Areas/" 2>/dev/null | sed 's/\.md$//' | tr '\n' ', ' | sed 's/,$//')
TODAY=$(date +"%Y-%m-%d")

cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": "BRAIN DUMP — Full processing instructions. Brain: ${BRAIN_PATH}. Today: ${TODAY}.\n\nEXISTING: People: ${PEOPLE:-none}. Projects: ${PROJECTS:-none}. Areas: ${AREAS:-none}.\n\n1. ROUTING:\n- Person interaction → People/name.md\n- Task/TODO → Tasks/tasks.md\n- Project work → Projects/name/name.md\n- Technical learning → Notes/topic.md\n- Decision → Notes/decision-topic.md\n- Daily log → Journal/${TODAY}.md\n- Area (career/health/family/finances) → Areas/area.md\n- Link/article → Resources/\n- Unclear → Inbox/\n\n2. PROCESSING:\n- READ existing file FIRST — match style, append don't replace\n- YAML frontmatter: created, updated (today), tags\n- Use [[wikilinks]] everywhere — Obsidian handles backlinks automatically\n- File names: kebab-case.md\n- People files: firstname.md or firstname-lastname.md\n- Link format: [[People/name]] or [[Projects/name/name|Display Name]]\n\n3. LINKING (Obsidian-native):\n- Link FORWARD from where you write. Obsidian shows backlinks automatically.\n- Do NOT manually create reverse links — Obsidian's Backlinks panel handles that.\n- Use [[wikilinks]] to connect: [[People/name]], [[Projects/name/name|Name]], [[Notes/topic]]\n- In frontmatter use related: [\"[[Notes/topic]]\", \"[[Projects/name/name]]\"]\n\n4. WHEN TO WRITE CONTENT IN MULTIPLE FILES (not just links):\n- Only update multiple files when adding ACTUAL CONTENT, not just backlinks:\n- People/name.md → Add meaningful interaction entry to ## Interactions, update last_contact\n- Projects/name/name.md → Add work log entry to ## Log with what was done\n- Journal/date.md → Daily summary grouped by project with [[wikilinks]] to everything\n- Tasks/tasks.md → New tasks with [[Projects/name/name|Name]] and date\n- Persona.md → New evidence line if behavioral pattern observed\n\n5. FORMAT:\n- People: frontmatter (created, updated, tags, role, relationship, last_contact), sections: ## Who, ## De retinut, ## Interactions\n- Projects: sections: ## Overview, ## Active Tasks, ## Log\n- Journal: sections grouped by ## Project Name (not chronological)\n- Tasks: - [ ] Description [[Projects/name/name|Name]] (YYYY-MM-DD)\n- Notes: frontmatter with related: wikilinks array\n\n6. AFTER SAVE — Report:\n- List all files created/updated\n- Confirm [[wikilinks]] added (Obsidian will handle backlinks)"
  }
}
EOF

exit 0
