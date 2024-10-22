#!/bin/bash

cp tailwind.config.js widgets/
cp tailwind.config.js editor/

cd widgets
gleam run -m lustre/dev build --outdir=../backend/priv --minify=true --detect-tailwind=true
cd ..

cd editor
gleam run -m lustre/dev build --outdir=../backend/priv --minify=true --detect-tailwind=true
cd ..

cd backend
gleam build
gleam export erlang-shipment
cd ..