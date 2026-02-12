#!/bin/bash
set -euo pipefail
# Remember - Session Start Hook
# Loads Persona.md into Claude's context at the start of every session.

BRAIN_PATH="${REMEMBER_BRAIN_PATH:-$HOME/remember}"

[ ! -d "$BRAIN_PATH" ] && exit 0

# Load Persona
PERSONA=""
[ -f "$BRAIN_PATH/Persona.md" ] && PERSONA=$(cat "$BRAIN_PATH/Persona.md")
[ -z "$PERSONA" ] && exit 0

cat <<EOF
REMEMBER BRAIN LOADED. Brain: ${BRAIN_PATH}

PERSONA (apply throughout session):
${PERSONA}

Commands: /brain:process, /brain:status, 'remember this: ...'
EOF

exit 0
