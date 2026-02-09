#!/bin/bash
# Remember - User Prompt Hook
# Detects brain dump intent in user messages and injects routing context.
# Fires on every UserPromptSubmit — exits fast (no-op) when no keywords match.

[ "$REMEMBER_PROCESSING" = "1" ] && exit 0

# Read stdin (Claude Code passes JSON with prompt, session_id, cwd, etc.)
INPUT=$(cat)

# Convert to lowercase for case-insensitive matching
LOWER_INPUT=$(echo "$INPUT" | tr '[:upper:]' '[:lower:]')

# Check for brain dump keywords
BRAIN_DUMP=false
for keyword in "save this" "remember this" "brain dump" "note to self" "capture this" "save to brain" "write to brain" "add to brain" "salvează" "notează" "reține"; do
  if echo "$LOWER_INPUT" | grep -qF "$keyword"; then
    BRAIN_DUMP=true
    break
  fi
done

# If no brain dump detected, exit silently (no output = no-op)
if [ "$BRAIN_DUMP" = false ]; then
  exit 0
fi

# Resolve brain path from user config
USER_CONFIG="$HOME/.claude/plugins/remember/config.json"
BRAIN_PATH=""
if [ -f "$USER_CONFIG" ]; then
  BRAIN_PATH=$(grep -o '"data_root": "[^"]*"' "$USER_CONFIG" | cut -d'"' -f4)
fi
BRAIN_PATH="${BRAIN_PATH:-$HOME/second-brain}"
BRAIN_PATH="${BRAIN_PATH/#\~/$HOME}"

# Build current brain structure listing for routing context
STRUCTURE=""
if [ -d "$BRAIN_PATH" ]; then
  PEOPLE=$(ls "$BRAIN_PATH/People/" 2>/dev/null | sed 's/\.md$//' | tr '\n' ', ' | sed 's/,$//')
  PROJECTS=$(ls -d "$BRAIN_PATH/Projects/"*/ 2>/dev/null | xargs -I{} basename {} | tr '\n' ', ' | sed 's/,$//')
  AREAS=$(ls "$BRAIN_PATH/Areas/" 2>/dev/null | sed 's/\.md$//' | tr '\n' ', ' | sed 's/,$//')
  STRUCTURE="Existing People: ${PEOPLE:-none}. Existing Projects: ${PROJECTS:-none}. Existing Areas: ${AREAS:-none}."
fi

# Inject routing context for Claude
cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": "BRAIN DUMP: Save to ${BRAIN_PATH}/. ${STRUCTURE} Routing: People -> People/name.md (use existing file if person exists), Tasks/TODOs -> Tasks/tasks.md, Projects -> Projects/name/name.md, Technical learning -> Notes/topic.md, Daily log -> Journal/YYYY-MM-DD.md, Decisions -> Notes/decision-topic.md, Career/professional -> Areas/career.md, Health -> Areas/health.md, Family -> Areas/family.md, Finances -> Areas/finances.md, Links/articles -> Resources/, Unclear -> Inbox/. Use YAML frontmatter (created, updated, tags) + wikilinks. Read existing file first to match style and append."
  }
}
EOF

exit 0
