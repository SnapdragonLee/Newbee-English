git pull
git submodule update --init --recursive --force

cd frontend
npm run build
cd ..

rm -rf ./backend/src/mysite/dist
cp -r ./frontend/dist ./backend/src/mysite