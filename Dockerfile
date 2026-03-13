# syntax=docker/dockerfile:1

FROM node:20-alpine AS builder
WORKDIR /app

COPY package.json ./
RUN npm install --no-audit --no-fund

COPY . .
RUN npm run build

FROM nginx:1.27-alpine AS runner
ENV BRAND_NAME=veriq

COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY docker/30-runtime-config.sh /docker-entrypoint.d/30-runtime-config.sh
RUN chmod +x /docker-entrypoint.d/30-runtime-config.sh
COPY --from=builder /app/dist /usr/share/nginx/html
RUN find /usr/share/nginx/html -type d -exec chmod 755 {} \; \
 && find /usr/share/nginx/html -type f -exec chmod 644 {} \;

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD wget -qO- http://127.0.0.1/healthz || exit 1

CMD ["nginx", "-g", "daemon off;"]
