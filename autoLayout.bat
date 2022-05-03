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

rd /s /q backend\src\mysite\dist\

cd frontend
call npm run build 2 > nul
cd .. 

xcopy frontend\dist backend\src\mysite\dist\ /s /h /c /y
pause