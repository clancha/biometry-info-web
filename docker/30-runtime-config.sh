#!/bin/sh
set -eu

WEB_ROOT="/usr/share/nginx/html"
BRAND_PRESET_VALUE="${BRAND_PRESET:-veriq}"

case "$BRAND_PRESET_VALUE" in
  veriq)
    BRAND_NAME_VALUE="veriq"
    BRAND_LOGO_VALUE="/brand/Logo_veriq.png"
    ;;
  humanlayer)
    BRAND_NAME_VALUE="humanlayer"
    BRAND_LOGO_VALUE="/brand/Logo_humanlayer.png"
    ;;
  humyx)
    BRAND_NAME_VALUE="humyx"
    BRAND_LOGO_VALUE="/brand/Logo_humyx.png"
    ;;
  zeryon)
    BRAND_NAME_VALUE="zeryon"
    BRAND_LOGO_VALUE="/brand/Logo_zeryon.png"
    ;;
  *)
    echo "[brand] ERROR: BRAND_PRESET invalido: '$BRAND_PRESET_VALUE'" >&2
    echo "[brand] Valores permitidos: veriq, humanlayer, humyx, zeryon" >&2
    exit 1
    ;;
esac

if [ ! -f "$WEB_ROOT$BRAND_LOGO_VALUE" ]; then
  echo "[brand] ERROR: no existe el logo esperado: $WEB_ROOT$BRAND_LOGO_VALUE" >&2
  exit 1
fi

echo "[brand] BRAND_PRESET=$BRAND_PRESET_VALUE"
echo "[brand] BRAND_NAME=$BRAND_NAME_VALUE"
echo "[brand] BRAND_LOGO=$BRAND_LOGO_VALUE"

cat > "$WEB_ROOT/runtime-config.js" <<RUNTIME_EOF
window.__VERIQ_RUNTIME_CONFIG__ = {
  BRAND_NAME: "$BRAND_NAME_VALUE",
  BRAND_LOGO: "$BRAND_LOGO_VALUE",
};
RUNTIME_EOF
