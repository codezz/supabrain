#!/bin/bash
# BrainRepo - Observation Capture Script
# Captures 100% of tool use via hooks

set -e

# Get plugin root
PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Read config to get data_root
CONFIG_FILE="$PLUGIN_ROOT/config.json"
DATA_ROOT=$(grep -o '"data_root": "[^"]*"' "$CONFIG_FILE" | cut -d'"' -f4)
DATA_ROOT="${DATA_ROOT/#\~/$HOME}"

# Observations file
OBS_DIR="$DATA_ROOT/learning/observations"
OBS_FILE="$OBS_DIR/current.jsonl"

# Create observations dir if needed
mkdir -p "$OBS_DIR"

# Get hook phase (pre or post)
PHASE="${1:-unknown}"

# Get timestamp
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Get current working directory (project context)
PROJECT_DIR="$PWD"
PROJECT_NAME=$(basename "$PROJECT_DIR")

# Capture observation
# Note: In real Claude Code hooks, you'd have access to tool info
# For now, we log basic info
cat >> "$OBS_FILE" <<EOF
{"timestamp":"$TIMESTAMP","phase":"$PHASE","project":"$PROJECT_NAME","cwd":"$PROJECT_DIR"}
EOF

exit 0
