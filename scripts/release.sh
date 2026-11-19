#!/bin/bash
# Kullanim: ./scripts/release.sh KULLANICI_ADI v1.0
set -e
[ $# -ne 2 ] && { echo "Kullanim: $0 <kullanici> <versiyon>"; exit 1; }
IMAGE="$1/takvim-web"
docker build -t "$IMAGE:$2" -t "$IMAGE:latest" \
  --build-arg APP_VERSION="$2" --build-arg BUILD_DATE="$(date '+%Y-%m-%d %H:%M')" .
docker push "$IMAGE:$2"
docker push "$IMAGE:latest"
echo "Tamam: https://hub.docker.com/r/$IMAGE/tags"
