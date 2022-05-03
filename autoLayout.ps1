git pull
git submodule update --init --recursive --force

cd backend
git checkout -b new
git checkout master
git merge new
git branch -d new

cd ../frontend
git checkout -b new
git checkout main
git merge new
git branch -d new
cd ..

rm -r ./backend/src/mysite/dist

cd frontend
npm run build
cd ..

cp -r ./frontend/dist ./backend/src/mysite
pause