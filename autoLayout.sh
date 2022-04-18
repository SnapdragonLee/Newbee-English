git pull
git pull --recurse-submodules

cd frontend
npm run build
cd ..

rm -rf ./backend/src/mysite/dist
cp -r ./frontend/dist ./backend/src/mysite