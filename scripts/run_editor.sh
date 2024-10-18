#!/bin/bash

mkdir -p editor/priv/static/font
cp backend/priv/fonts.css editor/priv/static/fonts.css
cp -r backend/priv/font/* editor/priv/static/font/
cp index.html editor/
cp tailwind.config.js editor/


cd editor
gleam run -m lustre/dev start --detect-tailwind=true --port=8161
cd ..