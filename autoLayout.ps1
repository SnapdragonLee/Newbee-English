git pull
git submodule update --init --recursive --force

rm -r ./backend/src/mysite/dist

cd frontend
npm run build
cd ..

cp -r ./frontend/dist ./backend/src/mysite
pause