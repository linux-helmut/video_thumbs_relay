# Download the upstream worker in a separate build stage.
FROM alpine/git AS upstream
ARG UPSTREAM_REF=main
RUN git clone --depth 1 --branch "${UPSTREAM_REF}" \
    https://github.com/silversong88/video_thumbs_relay.git /src

FROM node:lts-slim
ENV NODE_ENV=production

RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Use the upstream dependency manifests.
COPY --from=upstream /src/worker/package.json /src/worker/package-lock.json ./
RUN npm ci --omit=dev \
    && npm cache clean --force

# Copy the upstream worker, then overlay the local modification.
COPY --from=upstream /src/worker/index.js ./index.js
COPY patches/index.js ./index.js

RUN mkdir -p /data/tmp_thumbs \
    && touch /app/.env \
    && chown -R node:node /app /data

USER node
CMD ["node", "index.js"]
