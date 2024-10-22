#!/bin/bash

TAILWIND_VERSION="v3.4.14"

OS="$(uname -s)"
case "$OS" in
    Linux*)     OS="linux";;
    Darwin*)    OS="macos";;
    CYGWIN*|MINGW*|MSYS*) OS="windows";;
    *)          echo "Unbekanntes Betriebssystem: $OS"; exit 1;;
esac

ARCH="$(uname -m)"
case "$ARCH" in
    x86_64)    ARCH="x64";;
    arm64|aarch64) ARCH="arm64";;
    armv7l)    ARCH="armv7";;
    *)         echo "Unbekannte Architektur: $ARCH"; exit 1;;
esac

FILENAME="tailwindcss-${OS}-${ARCH}"
if [ "$OS" = "windows" ]; then
    FILENAME="${FILENAME}.exe"
    OUTPUT_NAME="tailwind-css-cli.exe"
else
    OUTPUT_NAME="tailwind-css-cli"
fi

DOWNLOAD_URL="https://github.com/tailwindlabs/tailwindcss/releases/download/${TAILWIND_VERSION}/${FILENAME}"

echo "Downloading Tailwind CSS CLI from $DOWNLOAD_URL ..."
curl -L -o "$OUTPUT_NAME" "$DOWNLOAD_URL"

chmod +x "$OUTPUT_NAME"

npm install

cd widgets
gleam deps download
cd ..

cd editor
gleam deps download
cd ..

cd backend
gleam deps download
cd ..