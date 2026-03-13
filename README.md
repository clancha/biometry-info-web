# Biometry Info Web

Landing estática (Astro + Nginx) con branding configurable en runtime dentro del contenedor.

## Requisitos
- Docker instalado

## Logos disponibles en la imagen
Los logos que están en `public/brand/` se copian a la imagen y se pueden seleccionar con `BRAND_LOGO_FILE`.

Actualmente:
- `Logo_veriq.png`
- `Logo_humanlayer.png`
- `Logo_humyx.png`
- `Logo_zeryon.png`

## 1) Compilar imagen (una sola vez)
```bash
docker build -t biometry-info-web .
```

## 2) Ejecutar caso por defecto
Usa los defaults del contenedor:
- `BRAND_NAME=veriq`

```bash
docker run --rm -p 8080:80 biometry-info-web
```

## 3) Ejecutar cada caso de logo (sin volúmenes)
### Caso veriq
```bash
docker run --rm -p 8080:80 \
  -e BRAND_NAME="veriq" \
  -e BRAND_LOGO_FILE="Logo_veriq.png" \
  biometry-info-web
```

### Caso humanlayer
```bash
docker run --rm -p 8080:80 \
  -e BRAND_NAME="humanlayer" \
  -e BRAND_LOGO_FILE="Logo_humanlayer.png" \
  biometry-info-web
```

### Caso humyx
```bash
docker run --rm -p 8080:80 \
  -e BRAND_NAME="humyx" \
  -e BRAND_LOGO_FILE="Logo_humyx.png" \
  biometry-info-web
```

### Caso zeryon
```bash
docker run --rm -p 8080:80 \
  -e BRAND_NAME="zeryon" \
  -e BRAND_LOGO_FILE="Logo_zeryon.png" \
  biometry-info-web
```

## 4) Ejecutar nombre personalizado + logo interno
```bash
docker run --rm -p 8080:80 \
  -e BRAND_NAME="MiStartup" \
  -e BRAND_LOGO_FILE="Logo_humyx.png" \
  biometry-info-web
```

## 4.1) Solo cambiar nombre (auto logo por convención)
Si no pasas logo, el contenedor intenta usar `Logo_<BRAND_NAME>.png` dentro de `/brand`.

Ejemplo:
```bash
docker run --rm -p 8080:80 \
  -e BRAND_NAME="humyx" \
  biometry-info-web
```

Buscará `Logo_humyx.png`. Si no existe, usará `Logo_veriq.png`.

## 4.2) Usar `BRAND_LOGO` (opcional)
`BRAND_LOGO` acepta:
- Ruta absoluta web: `/brand/Logo_humyx.png`
- URL remota: `https://...`
- Nombre de archivo: `Logo_humyx.png` (se resuelve en `/brand`)

## 5) Añadir nuevos logos y recompilar
Si metes nuevos logos, tienen que ir en `public/brand/` para que entren en la imagen.

```bash
cp src/brand/Mi_logo_nuevo.png public/brand/
docker build -t biometry-info-web .
```

Luego:
```bash
docker run --rm -p 8080:80 \
  -e BRAND_NAME="MiStartup" \
  -e BRAND_LOGO_FILE="Mi_logo_nuevo.png" \
  biometry-info-web
```

## 6) Fallbacks
- Si `BRAND_LOGO_FILE` no existe en `/brand`, se usa `Logo_veriq.png`.
- Si no pasas logo, intenta `Logo_<BRAND_NAME>.png` y, si no existe, usa `Logo_veriq.png`.
- Si no pasas `BRAND_NAME`, se usa `veriq`.

## 8) Debug rápido
Ver qué eligió realmente el contenedor:

```bash
docker logs <container_id> | rg "^\[brand\]"
```

## 7) URL de prueba
Una vez arrancado:
- [http://localhost:8080/es](http://localhost:8080/es)
- [http://localhost:8080/en](http://localhost:8080/en)
