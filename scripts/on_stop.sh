#!/bin/bash
# Remember - Session Stop Hook
# Updates session count and last_session date in identity.json.
# Reads brain path from user config, falls back to plugin default.

[ "$REMEMBER_PROCESSING" = "1" ] && exit 0

set -e

# Resolve brain path
USER_CONFIG="$HOME/.claude/plugins/remember/config.json"
PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN_CONFIG="$PLUGIN_ROOT/config.json"

DATA_ROOT=""
if [ -f "$USER_CONFIG" ]; then
  DATA_ROOT=$(grep -o '"data_root": "[^"]*"' "$USER_CONFIG" | cut -d'"' -f4)
fi
if [ -z "$DATA_ROOT" ] && [ -f "$PLUGIN_CONFIG" ]; then
  DATA_ROOT=$(grep -o '"data_root": "[^"]*"' "$PLUGIN_CONFIG" | cut -d'"' -f4)
fi
DATA_ROOT="${DATA_ROOT:-$HOME/remember}"
DATA_ROOT="${DATA_ROOT/#\~/$HOME}"

# Paths
META_DIR="$DATA_ROOT/System-learnings/meta"
IDENTITY_FILE="$META_DIR/identity.json"

# If brain not initialized, exit silently
[ ! -d "$META_DIR" ] && exit 0
[ ! -f "$IDENTITY_FILE" ] && exit 0

# Update session count (macOS-compatible sed)
SESSIONS=$(grep -o '"sessions_count": [0-9]*' "$IDENTITY_FILE" | grep -o '[0-9]*')
SESSIONS=$((SESSIONS + 1))
LAST_SESSION=$(date +"%Y-%m-%d")

sed -i '' "s/\"sessions_count\": [0-9]*/\"sessions_count\": $SESSIONS/" "$IDENTITY_FILE" 2>/dev/null || \
sed -i "s/\"sessions_count\": [0-9]*/\"sessions_count\": $SESSIONS/" "$IDENTITY_FILE"

sed -i '' "s/\"last_session\": \"[^\"]*\"/\"last_session\": \"$LAST_SESSION\"/" "$IDENTITY_FILE" 2>/dev/null || \
sed -i "s/\"last_session\": \"[^\"]*\"/\"last_session\": \"$LAST_SESSION\"/" "$IDENTITY_FILE"

exit 0
