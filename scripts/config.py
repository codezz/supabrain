#!/usr/bin/env python3
"""Shared config for Remember plugin.

Brain path: $REMEMBER_BRAIN_PATH env var, fallback ~/remember
Settings: config.defaults.json from plugin root
"""

import json
import os
from pathlib import Path

_cached = None


def get_brain_root() -> Path:
    """Get brain root from env var, fallback ~/remember."""
    raw = os.environ.get("REMEMBER_BRAIN_PATH", "~/remember")
    return Path(os.path.expanduser(raw))


def load_config(*, force_reload: bool = False) -> dict:
    """Load config from config.defaults.json in plugin root."""
    global _cached
    if _cached and not force_reload:
        return _cached

    plugin_root = Path(__file__).resolve().parent.parent
    defaults_file = plugin_root / "config.defaults.json"

    try:
        with open(defaults_file, encoding="utf-8") as f:
            _cached = json.load(f)
    except (OSError, json.JSONDecodeError):
        _cached = {
            "session": {
                "brain_dump_keywords": [
                    "save this", "remember this", "brain dump", "note to self",
                    "capture this", "save to brain", "write to brain", "add to brain",
                    "salvează", "notează", "reține",
                ],
                "load_persona": True,
            },
            "extract": {
                "max_assistant_text_len": 500,
                "min_session_size": 500,
            },
        }

    return _cached


# CLI: print brain root or config key
if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        key = sys.argv[1]
        if key == "brain_root":
            print(get_brain_root())
        else:
            config = load_config()
            val = config
            for part in key.split("."):
                val = val.get(part, "") if isinstance(val, dict) else ""
            print(val if not isinstance(val, (dict, list)) else json.dumps(val))
    else:
        print(json.dumps(load_config(), indent=2))
