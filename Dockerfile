# Dockerfile originated from Isaac Harris-Holt
# (https://www.youtube.com/@IsaacHarrisHolt and https://github.com/isaacharrisholt)
# Thank you very much for your great tutorials!


###############################################################################


FROM alpine AS tailwind-css-cli

WORKDIR /app

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

RUN apk add --no-cache wget

ENV TAILWIND_VERSION=v3.4.15

RUN set -ex; \
  if [ "$TARGETOS" = "linux" ]; then \
  if [ "$TARGETARCH" = "amd64" ]; then \
  TAILWIND_FILENAME="tailwindcss-linux-x64"; \
  elif [ "$TARGETARCH" = "arm64" ]; then \
  TAILWIND_FILENAME="tailwindcss-linux-arm64"; \
  elif [ "$TARGETARCH" = "arm" ]; then \
  if [ "$TARGETVARIANT" = "v7" ]; then \
  TAILWIND_FILENAME="tailwindcss-linux-armv7"; \
  else \
  echo "Unsupported ARM variant $TARGETVARIANT"; exit 1; \
  fi; \
  else \
  echo "Unsupported architecture $TARGETARCH"; exit 1; \
  fi; \
  else \
  echo "Unsupported OS $TARGETOS"; exit 1; \
  fi; \
  echo "Downloading $TAILWIND_FILENAME"; \ 
  wget -O "/app/tailwind-css-cli" "https://github.com/tailwindlabs/tailwindcss/releases/download/$TAILWIND_VERSION/$TAILWIND_FILENAME"; \
  chmod +x "/app/tailwind-css-cli"


###############################################################################


# This container is used to download the node dependencies
FROM node:22.6.0-alpine3.20 AS node-dependencies

WORKDIR /build

COPY package.json package-lock.json /build/

RUN npm ci


###############################################################################


# This container is used to build the widgets
FROM ghcr.io/gleam-lang/gleam:v1.6.2-erlang-alpine AS widgets-builder

WORKDIR /build

COPY widgets /build/widgets
COPY tailwind.config.js /build/widgets/

COPY --from=node-dependencies /build/node_modules /build/node_modules

RUN cd /build/widgets \
  && gleam run -m lustre/dev build --outdir=/build/backend/priv \
  --minify=true --detect-tailwind=true


###############################################################################


# This container is used to build the editor
FROM ghcr.io/gleam-lang/gleam:v1.6.2-erlang-alpine AS editor-builder

WORKDIR /build

COPY editor /build/editor
COPY tailwind.config.js /build/editor/

COPY --from=node-dependencies /build/node_modules /build/node_modules
COPY --from=widgets-builder /build/widgets /build/widgets
COPY --from=widgets-builder /build/widgets/build /build/editor/build

RUN cd /build/editor \
  && gleam run -m lustre/dev build --outdir=/build/backend/priv \
  --minify=true --detect-tailwind=true


###############################################################################


# This container is used to build the full stack application
FROM ghcr.io/gleam-lang/gleam:v1.6.2-erlang-alpine AS builder

# Add dependencies required to build SQLite
RUN apk add --no-cache build-base sqlite-dev

WORKDIR /build

COPY immutype_lite /build/immutype_lite
COPY sqlight /build/sqlight
COPY backend /build/backend

COPY --from=widgets-builder /build/widgets /build/widgets
COPY --from=editor-builder /build/editor /build/editor
COPY --from=editor-builder /build/editor/build /build/backend/build

COPY --from=editor-builder \
  /build/backend/priv/editor.min.css \
  /build/backend/priv/editor.min.mjs \
  /build/backend/priv/

COPY --from=widgets-builder \
  /build/backend/priv/widgets.min.css \
  /build/backend/priv/widgets.min.mjs \
  /build/backend/priv/

RUN cd /build/backend \
  && gleam export erlang-shipment \
  && mv build/erlang-shipment /app


###############################################################################


# This container is used to run the full stack application
FROM ghcr.io/gleam-lang/gleam:v1.6.2-erlang-alpine AS runtime

COPY --from=tailwind-css-cli /app/tailwind-css-cli /app/tailwind-css-cli
COPY --from=node-dependencies /build/node_modules /app/node_modules

COPY --from=builder /app /app

WORKDIR /app

EXPOSE 8161

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 CMD \
  wget --no-verbose --tries=1 --spider http://127.0.0.1:8161 || exit 1

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["run"]
