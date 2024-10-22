#!/bin/bash

rm -rf package-lock.json
rm -rf node_modules
npx -y npm-check-updates -u && npm i

cd widgets
rm -rf manifest.toml
rm -rf build
gleam deps download
cd ..

cd editor
rm -rf manifest.toml
rm -rf build
gleam deps download
cd ..

cd backend
rm -rf manifest.toml
rm -rf build
gleam deps download
cd ..