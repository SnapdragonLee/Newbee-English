git pull
git submodule update --init --recursive --force

cd backend
git merge master
git checkout master

cd ../frontend
git merge main
git checkout main
cd ..

rm -r ./backend/src/mysite/dist

cd frontend
npm run build
cd ..

cp -r ./frontend/dist ./backend/src/mysite
pause