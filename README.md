# Biometry Info Web

Landing estática (Astro + Nginx) con branding configurable por **una sola variable**:

- `BRAND_PRESET`

Valores permitidos (hardcoded):
- `veriq`
- `humanlayer`
- `humyx`
- `zeryon`

Si pasas otro valor, el contenedor falla al arrancar con error explícito.

## Requisitos
- Docker instalado

## Dónde están los logos
Solo se usan desde:
- `public/brand/`

Archivos hardcoded actuales:
- `Logo_veriq.png`
- `Logo_humanlayer.png`
- `Logo_humyx.png`
- `Logo_zeryon.png`

## 1) Build
```bash
docker build -t biometry-info-web .
```

## 2) Run por defecto
```bash
docker run --rm -p 8080:80 biometry-info-web
```

## 3) Run por preset
### veriq
```bash
docker run --rm -p 8080:80 -e BRAND_PRESET=veriq biometry-info-web
```

### humanlayer
```bash
docker run --rm -p 8080:80 -e BRAND_PRESET=humanlayer biometry-info-web
```

### humyx
```bash
docker run --rm -p 8080:80 -e BRAND_PRESET=humyx biometry-info-web
```

### zeryon
```bash
docker run --rm -p 8080:80 -e BRAND_PRESET=zeryon biometry-info-web
```

## 4) Error intencional si está mal
```bash
docker run --rm -p 8080:80 -e BRAND_PRESET=loquesea biometry-info-web
```

El contenedor debe terminar con error indicando valores válidos.

## 5) Logs de diagnóstico
```bash
docker logs <container_id> | rg "^\[brand\]"
```

## 6) URLs
- [http://localhost:8080/es](http://localhost:8080/es)
- [http://localhost:8080/en](http://localhost:8080/en)
