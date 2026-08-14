@echo off
REM 使用 NSIS 生成安装程序
REM 需先安装 NSIS: https://nsis.sourceforge.io/
chcp 65001 >nul
setlocal

REM 切换到项目根目录（本脚本位于 build\ 下）
cd /d "%~dp0.."

echo.
echo ============================================
echo  AI Desktop Pet 安装程序生成
echo ============================================
echo.

set DIST=dist\AIDesktopPet
if not exist "%DIST%\AIDesktopPet.exe" (
    echo [错误] 未找到打包产物，请先运行 build\build.bat
    pause
    exit /b 1
)

where makensis >nul 2>nul
if errorlevel 1 (
    echo [错误] 未找到 makensis，请安装 NSIS: https://nsis.sourceforge.io/
    echo        安装后请勾选 "Add NSIS to PATH"（或在环境变量中加入 NSIS 安装目录）
    pause
    exit /b 1
)

makensis /DAPP_DIR="%DIST%" build\installer.nsi
if errorlevel 1 (
    echo [错误] 安装程序生成失败，请检查上方错误信息
    pause
    exit /b 1
)

echo.
echo 安装程序已生成: %CD%\dist\AIDesktopPet-Setup.exe
echo.
pause
exit /b 0
