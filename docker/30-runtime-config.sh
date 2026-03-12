#!/bin/sh
set -eu

BRAND_NAME_VALUE="${BRAND_NAME:-veriq}"
BRAND_LOGO_VALUE="${BRAND_LOGO:-}"
BRAND_LOGO_FILE_VALUE="${BRAND_LOGO_FILE:-}"
DEFAULT_LOGO="/brand/Logo_veriq.png"

if [ -n "$BRAND_LOGO_FILE_VALUE" ]; then
  BRAND_LOGO_FILE_VALUE="${BRAND_LOGO_FILE_VALUE##*/}"
  CANDIDATE_LOGO="/brand/$BRAND_LOGO_FILE_VALUE"
  if [ -f "/usr/share/nginx/html$CANDIDATE_LOGO" ]; then
    BRAND_LOGO_VALUE="$CANDIDATE_LOGO"
  else
    BRAND_LOGO_VALUE="$DEFAULT_LOGO"
  fi
fi

if [ -z "$BRAND_LOGO_VALUE" ]; then
  BRAND_LOGO_VALUE="$DEFAULT_LOGO"
fi

escape_js() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

cat > /usr/share/nginx/html/runtime-config.js <<RUNTIME_EOF
window.__VERIQ_RUNTIME_CONFIG__ = {
  BRAND_NAME: "$(escape_js "$BRAND_NAME_VALUE")",
  BRAND_LOGO: "$(escape_js "$BRAND_LOGO_VALUE")",
};
RUNTIME_EOF
