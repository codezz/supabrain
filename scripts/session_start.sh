#!/bin/bash
# Remember - Session Start Hook
# Loads Persona.md into Claude's context at the start of every session.
# Fires once on SessionStart. Stdout is injected as model-visible context.

# Resolve plugin root
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"

# Read brain path from config. Search order:
#   1. ~/.claude/plugin-config/remember/config.json  (user scope, persistent)
#   2. .claude/plugin-config/remember/config.json    (project scope, persistent)
#   3. ${PLUGIN_ROOT}/config.defaults.json           (shipped default)
#   4. Hardcoded ~/remember
BRAIN_PATH=""
for cfg in \
  "$HOME/.claude/plugin-config/remember/config.json" \
  ".claude/plugin-config/remember/config.json" \
  "${PLUGIN_ROOT}/config.defaults.json"; do
  [ -f "$cfg" ] || continue
  BRAIN_PATH=$(python3 -c "
import json
try:
    with open('$cfg') as f:
        print(json.load(f).get('paths', {}).get('data_root', ''))
except Exception:
    pass
" 2>/dev/null)
  [ -n "$BRAIN_PATH" ] && break
done
BRAIN_PATH="${BRAIN_PATH:-$HOME/remember}"
BRAIN_PATH="${BRAIN_PATH/#\~/$HOME}"

[ ! -d "$BRAIN_PATH" ] && exit 0

# Load Persona
PERSONA=""
[ -f "$BRAIN_PATH/Persona.md" ] && PERSONA=$(cat "$BRAIN_PATH/Persona.md")
[ -z "$PERSONA" ] && exit 0

# Escape for JSON
ESCAPED_PERSONA=$(python3 -c "
import json, sys
print(json.dumps(sys.stdin.read())[1:-1])
" <<< "$PERSONA")

cat <<EOF
REMEMBER BRAIN LOADED. Brain: ${BRAIN_PATH}

PERSONA (apply throughout session):
${ESCAPED_PERSONA}

Commands: /brain:process, /brain:status, 'remember this: ...'
EOF

exit 0
