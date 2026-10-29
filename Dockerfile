
FROM node:lts-slim

ENV NODE_ENV=production

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ffmpeg \
       git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Originalprojekt beziehen
ARG UPSTREAM_REF=main
RUN git clone https://github.com/silversong88/video_thumbs_relay.git /tmp/upstream \
    && mkdir -p /app \
    && cp /tmp/upstream/worker/package.json /app/package.json \
    && cp /tmp/upstream/worker/package-lock.json /app/package-lock.json

# Node-Abhängigkeiten installieren
RUN npm ci --omit=dev

# Original-Worker übernehmen
RUN cp /tmp/upstream/worker/index.js /app/index.js

# Eigene Änderungen anwenden
COPY patches/index.js /app/index.js

RUN mkdir -p /tmp/video-thumbs-relay \
    && rm -rf /tmp/upstream

CMD ["node", "index.js"]
