git pull
git pull --recurse-submodules

rd /s /q backend\src\mysite\dist\

cd frontend

call npm run build 2 > nul
cd .. 

xcopy frontend\dist backend\src\mysite\dist\ /s /h /c /y
pause