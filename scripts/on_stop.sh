#!/bin/bash
# Remember - Session Stop Hook
# Triggered at session end

set -e

PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$PLUGIN_ROOT/config.json"
DATA_ROOT=$(grep -o '"data_root": "[^"]*"' "$CONFIG_FILE" | cut -d'"' -f4)
DATA_ROOT="${DATA_ROOT/#\~/$HOME}"

META_DIR="$DATA_ROOT/learning/meta"
IDENTITY_FILE="$META_DIR/identity.json"

# Ensure meta dir exists
mkdir -p "$META_DIR"

# Update session count
if [ -f "$IDENTITY_FILE" ]; then
  # Increment session count (simple approach)
  SESSIONS=$(grep -o '"sessions_count": [0-9]*' "$IDENTITY_FILE" | grep -o '[0-9]*')
  SESSIONS=$((SESSIONS + 1))
  
  # Update last session date
  LAST_SESSION=$(date -u +"%Y-%m-%d")
  
  # Simple update (in production, use jq or proper JSON parser)
  sed -i "s/\"sessions_count\": [0-9]*/\"sessions_count\": $SESSIONS/" "$IDENTITY_FILE"
  sed -i "s/\"last_session\": \"[^\"]*\"/\"last_session\": \"$LAST_SESSION\"/" "$IDENTITY_FILE"
fi

exit 0
