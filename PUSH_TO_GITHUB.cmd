cd /d "%~dp0"

git init
git add .
git commit -m "Deploy IFRS9 GRAP104 enterprise actuarial engine"
git branch -M main
git remote remove origin
git remote add origin https://github.com/Trodm/IFRS9_GRAP104_BigData_Engine.git
git push -u origin main
pause
