git pull
git submodule update --init --recursive --force

rd /s /q backend\src\mysite\dist\

cd frontend

call npm run build 2 > nul
cd .. 

xcopy frontend\dist backend\src\mysite\dist\ /s /h /c /y
pause