@echo off
REM ============================================
REM  AI Desktop Pet - 本地启动脚本
REM  首次运行会自动安装依赖，之后双击直接启动
REM ============================================
chcp 65001 >nul
setlocal

REM 切换到项目根目录
cd /d "%~dp0"

echo.
echo ============================================
echo  AI Desktop Pet 启动中...
echo ============================================
echo.

where python >nul 2>nul
if errorlevel 1 (
    echo [错误] 未找到 python，请安装 Python 3.10+ 并勾选 "Add to PATH"
    pause
    exit /b 1
)

REM 检查依赖是否已安装，未安装则自动安装
python -c "import PySide6" >nul 2>nul
if errorlevel 1 (
    echo [首次运行] 正在安装依赖，请稍候...
    python -m pip install --upgrade pip
    python -m pip install -r requirements.txt || (
        echo [错误] 依赖安装失败，请检查网络后重试
        pause
        exit /b 1
    )
    echo 依赖安装完成。
) else (
    echo 依赖已就绪。
)

echo.
echo 正在启动桌宠...
echo 提示：关闭此窗口或右键托盘选"退出"即可关闭桌宠
echo.
python main.py
pause
