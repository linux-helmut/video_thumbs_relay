
FROM node:lts-slim

ENV NODE_ENV=production

# FFmpeg für die Videoverarbeitung installieren
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Abhängigkeiten installieren
COPY worker/package*.json ./
RUN npm ci --omit=dev

# Worker-Code bereitstellen
COPY worker/ ./

# Verzeichnis für temporäre Dateien
RUN mkdir -p /tmp/video-thumbs-relay

CMD ["npm", "start"]
