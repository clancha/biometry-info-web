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
- `BRAND_LOGO_FILE=Logo_veriq.png`

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
- Si no pasas `BRAND_NAME`, se usa `veriq`.

## 7) URL de prueba
Una vez arrancado:
- [http://localhost:8080/es](http://localhost:8080/es)
- [http://localhost:8080/en](http://localhost:8080/en)
