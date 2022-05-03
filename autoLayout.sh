git pull
git submodule update --init --recursive --force

cd backend
git merge master
git checkout master

cd ../frontend
git merge main
git checkout main
npm run build
cd ..

rm -rf ./backend/src/mysite/dist
cp -r ./frontend/dist ./backend/src/mysite