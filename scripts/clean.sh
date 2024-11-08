#!/bin/bash

rm -rf node_modules\
    tailwind-css-cli.exe\
    tailwind-css-cli

rm -rf backend/build\
    editor/build\
    immutype_lite/build\
    widgets/build

rm -rf backend/priv/editor.min.css\
    backend/priv/editor.min.mjs\
    backend/priv/widgets.min.css\
    backend/priv/widgets.min.mjs

rm -rf backend/data\
    backend/tmp

rm -rf editor/priv\
    widgets/priv

rm -rf editor/index.html\
    widgets/index.html

rm -rf editor/tailwind.config.js\
    widgets/tailwind.config.js