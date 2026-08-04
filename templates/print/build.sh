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

escape_sed() {
  printf '%s' "$1" | sed 's/[\\&|]/\\&/g'
}

stamp() {
  local title
  local name
  local out="$3"
  title="$(escape_sed "$1")"
  name="$(escape_sed "$2")"
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
