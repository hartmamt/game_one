@echo off
REM Auto-build Castle Eidolon to Windows .exe

echo ==========================================
echo Castle Eidolon - Windows Build Script
echo ==========================================
echo.

REM Check if Godot exists in common locations
set GODOT_PATH=
if exist "C:\Program Files\Godot\Godot.exe" set GODOT_PATH=C:\Program Files\Godot\Godot.exe
if exist "C:\Godot\Godot_v4.3_win64.exe" set GODOT_PATH=C:\Godot\Godot_v4.3_win64.exe
if exist "%USERPROFILE%\Downloads\Godot_v4.3_win64.exe" set GODOT_PATH=%USERPROFILE%\Downloads\Godot_v4.3_win64.exe

if "%GODOT_PATH%"=="" (
    echo ERROR: Godot not found!
    echo.
    echo Please either:
    echo   1. Download Godot 4.3 to your Downloads folder
    echo   2. Or edit this script to point to your Godot.exe location
    echo.
    echo Download from: https://godotengine.org/download
    pause
    exit /b 1
)

echo Found Godot at: %GODOT_PATH%
echo.

REM Create builds directory
if not exist builds mkdir builds

echo Building Windows .exe...
echo.

REM Export the project
"%GODOT_PATH%" --headless --export-release "Windows Desktop" builds\CastleEidolon.exe

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ==========================================
    echo BUILD SUCCESSFUL!
    echo ==========================================
    echo.
    echo Your .exe is ready at: builds\CastleEidolon.exe
    echo.
    echo You can now:
    echo   - Double-click CastleEidolon.exe to play
    echo   - Share the builds\ folder with others
    echo   - Upload to Steam
) else (
    echo.
    echo BUILD FAILED
    echo Make sure export templates are installed in Godot:
    echo   Editor -^> Manage Export Templates -^> Download
)

echo.
pause
