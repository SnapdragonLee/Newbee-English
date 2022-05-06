git pull
git submodule update --init --recursive --force

cd backend || exit
git checkout -b new
git checkout master
git merge new
git branch -d new

cd ../frontend || exit
git checkout -b new
git checkout main
git merge new
git branch -d new

npm run build
cd ..

rm -rf ./backend/src/mysite/dist
cp -r ./frontend/dist ./backend/src/mysite