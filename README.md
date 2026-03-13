# Biometry Info Web

Landing estática (Astro + Nginx) con variantes de marca por **ruta web**, sin variables de entorno.

## Marcas disponibles (hardcoded)
- `veriq`
- `humanlayer`
- `humyx`
- `zeryon`

## Rutas
- `http://localhost:80/veriq`
- `http://localhost:80/humanlayer`
- `http://localhost:80/humyx`
- `http://localhost:80/zeryon`

Cada ruta redirige a su versión en español:
- `/<marca>/es`

También existe versión en inglés:
- `/<marca>/en`

Ejemplos:
- `http://localhost:80/humanlayer/es`
- `http://localhost:80/humanlayer/en`

## Logos
Solo se usan desde:
- `public/brand/`

Archivos esperados:
- `Logo_veriq.png`
- `Logo_humanlayer.png`
- `Logo_humyx.png`
- `Logo_zeryon.png`

## Build
```bash
docker build -t biometry-info-web .
```

## Run
```bash
docker run --rm -p 80:80 biometry-info-web
```

## Nota
Las rutas antiguas `/es` y `/en` siguen funcionando y redirigen a `/veriq/es` y `/veriq/en`.
