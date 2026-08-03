#!/usr/bin/env bash
# templates/print/build.sh
#
# Regenerates the three series print templates from _base.html.
# Run this whenever _base.html is updated.
#
# Usage:
#   cd templates/print/
#   bash build.sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE="$SCRIPT_DIR/_base.html"

stamp() {
  local title="$1"
  local name="$2"
  local out="$3"
  sed \
    -e "s|{{SERIES_TITLE}}|$title|g" \
    -e "s|{{SERIES_NAME}}|$name|g" \
    "$BASE" > "$out"
  echo "  wrote $out"
}

echo "Building print templates from _base.html …"
stamp "World State Brief"        "World State Brief"        "$SCRIPT_DIR/world-state-brief.html"
stamp "Civic Intelligence Brief" "Civic Intelligence Brief" "$SCRIPT_DIR/civic-intelligence-brief.html"
stamp "Narrative Operations"     "Narrative Operations"     "$SCRIPT_DIR/narrative-operations.html"
echo "Done."
