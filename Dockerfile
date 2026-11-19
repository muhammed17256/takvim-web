FROM nginx:alpine

# Build sirasinda alinir: --build-arg APP_VERSION=v1.0 --build-arg BUILD_DATE=...
ARG APP_VERSION=dev
ARG BUILD_DATE=bilinmiyor

LABEL org.opencontainers.image.title="takvim-web" \
      org.opencontainers.image.version="${APP_VERSION}" \
      org.opencontainers.image.created="${BUILD_DATE}"

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY site/ /usr/share/nginx/html/

# Versiyonu sayfalara gom ve version.json uret
RUN find /usr/share/nginx/html -type f \( -name '*.html' -o -name '*.js' \) \
      -exec sed -i "s/__APP_VERSION__/${APP_VERSION}/g" {} + \
 && printf '{"name":"takvim-web","version":"%s","built":"%s"}\n' "${APP_VERSION}" "${BUILD_DATE}" \
      > /usr/share/nginx/html/version.json

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
  CMD wget -qO- http://localhost/healthz || exit 1
