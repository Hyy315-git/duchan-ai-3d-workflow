@echo off
rem ============================================================
rem  AI + 3D project - Windows one-click launcher
rem  Activates the venv and runs the main program
rem ============================================================
setlocal

rem Run from the script's own directory; all paths are relative
cd /d "%~dp0"

rem Check that venv is installed
if not exist "venv\Scripts\python.exe" (
    echo [ERROR] venv not found. Run install.bat first.
    pause
    exit /b 1
)

echo [RUN] Activating venv and running src\main.py ...
call "venv\Scripts\activate.bat"
python src\main.py

echo.
echo [DONE] Program finished. Output is in the output\ directory.
pause
endlocal
