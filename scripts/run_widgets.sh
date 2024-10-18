#!/bin/bash

mkdir -p widgets/priv/static/font
cp backend/priv/fonts.css widgets/priv/static/fonts.css
cp -r backend/priv/font/* widgets/priv/static/font/
cp index.html widgets/
cp tailwind.config.js widgets/

cd widgets
gleam run -m lustre/dev start --detect-tailwind=true --port=8161
cd ..