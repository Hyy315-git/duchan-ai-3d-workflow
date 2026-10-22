@echo off
rem ============================================================
rem  AI + 3D 项目 Windows 一键安装脚本
rem  自动创建 venv 并安装 requirements.txt 中的依赖
rem ============================================================
setlocal

rem 切到脚本所在目录，后续全部使用相对路径
cd /d "%~dp0"

rem 1. 检查 Python
where python >nul 2>nul
if errorlevel 1 (
    echo [错误] 未检测到 Python，请先安装 Python 3.12（推荐）并勾选 "Add to PATH"
    pause
    exit /b 1
)

echo [1/3] 创建虚拟环境 venv ...
if not exist venv (
    python -m venv venv
    if errorlevel 1 (
        echo [错误] 创建虚拟环境失败
        pause
        exit /b 1
    )
) else (
    echo       venv 已存在，跳过创建
)

echo [2/3] 激活虚拟环境并升级 pip ...
call venv\Scripts\activate.bat
python -m pip install --upgrade pip

echo [3/3] 安装依赖 ...
python -m pip install -r requirements.txt
if errorlevel 1 (
    echo [错误] 依赖安装失败
    pause
    exit /b 1
)

echo.
echo ============================================================
echo  安装完成！后续开发请先激活环境：
echo      venv\Scripts\activate.bat
echo ============================================================
pause
endlocal
