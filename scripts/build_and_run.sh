cd editor
gleam run -m lustre/dev build --outdir=../backend/priv --minify=true --detect-tailwind=true
cd ..

cd widgets
gleam run -m lustre/dev build --outdir=../backend/priv --minify=true --detect-tailwind=true
cd ..

cd backend
gleam run
cd ..