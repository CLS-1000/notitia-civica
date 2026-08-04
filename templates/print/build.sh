#!/usr/bin/env bash
# templates/print/build.sh
#
# Regenerates the three series print templates from _base.html.
# Run this whenever _base.html is updated.
#
# Usage:
#   cd templates/print/
#   bash build.sh                 # Standard run
#   DEBUG=1 bash build.sh         # Diagnostic output
#   bash build.sh --validate      # Test mode (no output files)
#   bash build.sh --help          # Show this message
#
# Features:
#   - Robust sed escaping for special characters (\ & | /)
#   - Placeholder validation (ensures {{}} tags are replaced)
#   - Output file verification
#   - Detailed error reporting with exit codes
#   - Diagnostic output mode for troubleshooting
#

set -e

# ============================================================================
# Configuration & Setup
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE="$SCRIPT_DIR/_base.html"
DEBUG="${DEBUG:-0}"
VALIDATE_ONLY=0

# ============================================================================
# Logging Functions
# ============================================================================

log() { echo "[build.sh] $*" >&2; }
debug() { [[ "$DEBUG" == "1" ]] && echo "[DEBUG] $*" >&2; }
error() { echo "[ERROR] $*" >&2; exit 1; }

# ============================================================================
# Argument Parsing
# ============================================================================

while [[ $# -gt 0 ]]; do
  case "$1" in
    --validate)
      VALIDATE_ONLY=1
      log "Validation mode: testing without writing files"
      shift
      ;;
    --help)
      sed -n '4,19p' "$0" | sed 's/^# //'
      exit 0
      ;;
    *)
      error "Unknown argument: $1"
      ;;
  esac
done

# ============================================================================
# Pre-flight Validation
# ============================================================================

if [[ ! -f "$BASE" ]]; then
  error "Base template not found: $BASE"
fi

debug "Base template: $BASE"
debug "Script directory: $SCRIPT_DIR"

# Verify required placeholders exist in base
if ! grep -q "{{SERIES_TITLE}}" "$BASE"; then
  error "_base.html missing {{SERIES_TITLE}} placeholder"
fi
if ! grep -q "{{SERIES_NAME}}" "$BASE"; then
  error "_base.html missing {{SERIES_NAME}} placeholder"
fi

debug "Placeholders validated in base template"

# ============================================================================
# Core Functions
# ============================================================================

# escape_sed STRING
#   Escapes special characters for use in sed s/// replacement side.
#   Handles: backslash (\), ampersand (&), pipe (|)
#   Returns: escaped string safe for sed
#
escape_sed() {
  printf '%s' "$1" | sed 's/[\\&|]/\\&/g'
}

# stamp TITLE NAME OUTPUT_PATH
#   Substitutes {{SERIES_TITLE}} and {{SERIES_NAME}} in _base.html
#   Validates output before writing to disk.
#
#   Arguments:
#     $1 = Series title (e.g., "World State Brief")
#     $2 = Series name/display name
#     $3 = Output file path
#
stamp() {
  local title="$1"
  local name="$2"
  local out="$3"

  # Escape for sed (special chars that have meaning in s/// replacements)
  local escaped_title
  local escaped_name
  escaped_title=$(escape_sed "$title")
  escaped_name=$(escape_sed "$name")

  debug "Stamping: '$title' → '$name'"
  debug "  Escaped title: '$escaped_title'"
  debug "  Escaped name: '$escaped_name'"

  # Create temporary file for output
  local temp_out
  temp_out=$(mktemp) || error "Failed to create temp file"
  trap "rm -f '$temp_out'" RETURN

  # Apply sed substitutions using | as delimiter (safer than /)
  if ! sed \
    -e "s|{{SERIES_TITLE}}|${escaped_title}|g" \
    -e "s|{{SERIES_NAME}}|${escaped_name}|g" \
    "$BASE" > "$temp_out"; then
    error "sed substitution failed for $out"
  fi

  debug "Substitution complete"

  # === Validation: Check that all placeholders were replaced ===
  if grep -q "{{SERIES_TITLE}}" "$temp_out"; then
    error "Unreplaced {{SERIES_TITLE}} in output: $out"
  fi
  if grep -q "{{SERIES_NAME}}" "$temp_out"; then
    error "Unreplaced {{SERIES_NAME}} in output: $out"
  fi

  # === Validation: Check output is non-empty ===
  if [[ ! -s "$temp_out" ]]; then
    error "Output file is empty: $out"
  fi

  # === Validation: Check output looks like HTML ===
  if ! grep -q "</html>" "$temp_out"; then
    error "Output missing HTML closing tag: $out"
  fi

  debug "Output validation passed"

  # === Write to disk (if not in validation-only mode) ===
  if [[ $VALIDATE_ONLY -eq 0 ]]; then
    if ! mv "$temp_out" "$out"; then
      error "Failed to write output file: $out"
    fi
    echo "  wrote $out"
  else
    echo "  validated $out (test mode, not written)"
  fi
}

# ============================================================================
# Main Execution
# ============================================================================

echo "Building print templates from _base.html …"

if [[ $VALIDATE_ONLY -eq 1 ]]; then
  echo "(Test mode — validating but not writing files)"
  echo ""
fi

# Process each template
stamp "World State Brief"        "World State Brief"        "$SCRIPT_DIR/world-state-brief.html"
stamp "Civic Intelligence Brief" "Civic Intelligence Brief" "$SCRIPT_DIR/civic-intelligence-brief.html"
stamp "Narrative Operations"     "Narrative Operations"     "$SCRIPT_DIR/narrative-operations.html"

echo "Done."
exit 0
