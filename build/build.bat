@echo off
REM ============================================
REM  AI Desktop Pet - Windows 打包脚本
REM  需要先安装 Python 3.10+，再执行：
REM    pip install -r requirements.txt pyinstaller
REM ============================================
chcp 65001 >nul
setlocal enabledelayedexpansion

REM 切换到项目根目录（本脚本位于 build\ 下）
cd /d "%~dp0.."

echo.
echo ============================================
echo  AI Desktop Pet 打包工具
echo  工作目录: %CD%
echo ============================================
echo.

REM ---------- 检查 Python ----------
where python >nul 2>nul
if errorlevel 1 (
    echo [错误] 未找到 python 命令，请安装 Python 3.10+ 并勾选 "Add to PATH"
    pause
    exit /b 1
)

python --version 2>nul
if errorlevel 1 (
    echo [错误] python 命令无法运行，请检查安装
    pause
    exit /b 1
)

REM ---------- 检查 PyInstaller ----------
where pyinstaller >nul 2>nul
if errorlevel 1 (
    echo [提示] 未找到 pyinstaller，正在安装...
    python -m pip install --upgrade pip
    python -m pip install pyinstaller || (
        echo [错误] pyinstaller 安装失败，请检查网络后重试
        pause
        exit /b 1
    )
)

echo [1/3] 安装项目依赖...
python -m pip install -r requirements.txt || (
    echo [错误] 依赖安装失败
    pause
    exit /b 1
)

echo [2/3] 使用 PyInstaller 打包...
python -m PyInstaller --clean --noconfirm build\desktop-pet.spec || (
    echo [错误] 打包失败，请检查上方错误信息
    echo 常见原因：Python 3.13 需要 PySide6 6.8+，请执行
    echo   python -m pip install --upgrade PySide6
    pause
    exit /b 1
)

echo [3/3] 打包完成！
echo.
echo 产物目录: %CD%\dist\AIDesktopPet\
echo 单文件入口: %CD%\dist\AIDesktopPet\AIDesktopPet.exe
echo 如需生成安装程序，请安装 NSIS 后运行 build\make_installer.bat
echo.
pause
exit /b 0
