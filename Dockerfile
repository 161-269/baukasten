# Dockerfile originated from Isaac Harris-Holt
# (https://www.youtube.com/@IsaacHarrisHolt and https://github.com/isaacharrisholt)
# Thank you very much for your great tutorials!


###############################################################################


# This container is used to download the node dependencies
FROM node:22.6.0-alpine3.20 AS node-dependencies

WORKDIR /build

COPY package.json package-lock.json /build/

RUN npm install


###############################################################################


# This container is used to build the widgets
FROM ghcr.io/gleam-lang/gleam:v1.5.1-erlang-alpine AS widgets-builder

WORKDIR /build

COPY widgets /build/widgets
COPY jot /build/jot

RUN rm -rf /build/widgets/build \
  && rm -rf /build/widgets/priv \
  && mkdir -p /build/backend/priv

COPY --from=node-dependencies /build/node_modules /build/node_modules

RUN cd /build/widgets \
  && gleam run -m lustre/dev build --outdir=/build/backend/priv \
  --minify=true --detect-tailwind=true


###############################################################################


# This container is used to build the editor
FROM ghcr.io/gleam-lang/gleam:v1.5.1-erlang-alpine AS editor-builder

WORKDIR /build

COPY editor /build/editor
COPY jot /build/jot

RUN rm -rf /build/editor/build \
  && rm -rf /build/editor/priv \
  && mkdir -p /build/backend/priv

COPY --from=node-dependencies /build/node_modules /build/node_modules
COPY --from=widgets-builder /build/widgets /build/widgets

RUN cd /build/editor \
  && gleam run -m lustre/dev build --outdir=/build/backend/priv \
  --minify=true --detect-tailwind=true


###############################################################################


# This container is used to build the full stack application
FROM ghcr.io/gleam-lang/gleam:v1.5.1-erlang-alpine AS builder

# Add dependencies required to build SQLite
RUN apk add --no-cache build-base sqlite-dev

WORKDIR /build

COPY backend /build/backend
COPY jot /build/jot

# Clean up previous build artifacts from the backend
RUN rm -rf /build/backend/build \
  && rm -f /build/backend/priv/editor.min.css \
  && rm -f /build/backend/priv/editor.min.mjs \
  && rm -f /build/backend/priv/widgets.min.css \
  && rm -f /build/backend/priv/widgets.min.mjs

COPY --from=node-dependencies /build/node_modules /build/node_modules
COPY --from=widgets-builder /build/widgets /build/widgets
COPY --from=editor-builder /build/editor /build/editor

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
FROM ghcr.io/gleam-lang/gleam:v1.5.1-erlang-alpine AS runtime

COPY --from=builder /app /app
WORKDIR /app

EXPOSE 8161

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 CMD \
  wget --no-verbose --tries=1 --spider http://localhost:8161/ || exit 1

  ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["run"]
