#!/bin/sh
set -eu

BRAND_NAME_VALUE="${BRAND_NAME:-veriq}"
BRAND_LOGO_VALUE="${BRAND_LOGO:-}"
BRAND_LOGO_FILE_VALUE="${BRAND_LOGO_FILE:-}"
DEFAULT_LOGO="/brand/Logo_veriq.png"
WEB_ROOT="/usr/share/nginx/html"
BRAND_DIR="$WEB_ROOT/brand"

to_lower() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]'
}

resolve_local_logo() {
  INPUT_FILE="$1"
  INPUT_FILE="${INPUT_FILE##*/}"
  [ -n "$INPUT_FILE" ] || return 1

  if [ -f "$BRAND_DIR/$INPUT_FILE" ]; then
    printf '/brand/%s' "$INPUT_FILE"
    return 0
  fi

  if [ "${INPUT_FILE#*.}" = "$INPUT_FILE" ] && [ -f "$BRAND_DIR/$INPUT_FILE.png" ]; then
    printf '/brand/%s.png' "$INPUT_FILE"
    return 0
  fi

  if [ -d "$BRAND_DIR" ]; then
    TARGET_LC="$(to_lower "$INPUT_FILE")"
    for LOGO_PATH in "$BRAND_DIR"/*; do
      [ -f "$LOGO_PATH" ] || continue
      LOGO_BASENAME="$(basename "$LOGO_PATH")"
      if [ "$(to_lower "$LOGO_BASENAME")" = "$TARGET_LC" ]; then
        printf '/brand/%s' "$LOGO_BASENAME"
        return 0
      fi
    done
  fi

  return 1
}

if [ -n "$BRAND_LOGO_FILE_VALUE" ]; then
  if RESOLVED_LOCAL="$(resolve_local_logo "$BRAND_LOGO_FILE_VALUE")"; then
    BRAND_LOGO_VALUE="$RESOLVED_LOCAL"
  else
    BRAND_LOGO_VALUE="$DEFAULT_LOGO"
  fi
fi

if [ -z "$BRAND_LOGO_VALUE" ]; then
  if RESOLVED_FROM_NAME="$(resolve_local_logo "Logo_${BRAND_NAME_VALUE}.png")"; then
    BRAND_LOGO_VALUE="$RESOLVED_FROM_NAME"
  else
    BRAND_LOGO_VALUE="$DEFAULT_LOGO"
  fi
fi

if [ -n "$BRAND_LOGO_VALUE" ]; then
  case "$BRAND_LOGO_VALUE" in
    http://*|https://*|/*) ;;
    *)
      if RESOLVED_FROM_BRAND_LOGO="$(resolve_local_logo "$BRAND_LOGO_VALUE")"; then
        BRAND_LOGO_VALUE="$RESOLVED_FROM_BRAND_LOGO"
      else
        BRAND_LOGO_VALUE="$DEFAULT_LOGO"
      fi
      ;;
  esac
fi

escape_js() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

echo "[brand] BRAND_NAME=$BRAND_NAME_VALUE"
echo "[brand] BRAND_LOGO=$BRAND_LOGO_VALUE"

cat > "$WEB_ROOT/runtime-config.js" <<RUNTIME_EOF
window.__VERIQ_RUNTIME_CONFIG__ = {
  BRAND_NAME: "$(escape_js "$BRAND_NAME_VALUE")",
  BRAND_LOGO: "$(escape_js "$BRAND_LOGO_VALUE")",
};
RUNTIME_EOF
