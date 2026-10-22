@echo off
rem ============================================================
rem  AI + 3D project - Windows one-click installer
rem  Creates a venv and installs requirements.txt
rem ============================================================
setlocal

rem Run from the script's own directory; all paths are relative
cd /d "%~dp0"

rem 1. Check Python
where python >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Python not found. Install Python 3.12 and check "Add to PATH".
    pause
    exit /b 1
)

echo [1/3] Creating virtual environment venv ...
if not exist venv (
    python -m venv venv
    if errorlevel 1 (
        echo [ERROR] Failed to create venv
        pause
        exit /b 1
    )
) else (
    echo       venv already exists, skipping
)

echo [2/3] Activating venv and upgrading pip ...
call venv\Scripts\activate.bat
python -m pip install --upgrade pip

echo [3/3] Installing dependencies ...
python -m pip install -r requirements.txt
if errorlevel 1 (
    echo [ERROR] Dependency installation failed
    pause
    exit /b 1
)

echo.
echo ============================================================
echo  Done! Activate the environment before developing:
echo      venv\Scripts\activate.bat
echo ============================================================
pause
endlocal
