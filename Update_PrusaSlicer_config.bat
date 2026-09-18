@echo off
setlocal
mode con: cols=60 lines=16

set "prusaslicer=prusa-slicer.exe"
set "repoauthor=YOUR GITHUB USERNAME"
set "reponame=YOUR GITHUB REPOSITORY NAME"

:: Check if repo author and name have been modified
if "%repoauthor%"=="YOUR GITHUB USERNAME" goto :repoauthormissing
if "%reponame%"=="YOUR GITHUB REPOSITORY NAME" goto :repoauthormissing

:: Verify Git installation
git --version >nul 2>&1 || goto :giterror

:: Close PrusaSlicer if running
tasklist /fi "imagename eq %prusaslicer%" 2>nul | find /i "%prusaslicer%" >nul
if not errorlevel 1 (
    echo:
    echo PrusaSlicer is running. Close it or press any key to kill it.
    pause >nul
    taskkill /f /im "%prusaslicer%" >nul 2>&1
)

:update
cls
echo:
echo Updating PrusaSlicer Config...

set "remotesource=https://github.com/%repoauthor%/%reponame%.git"
set "source=%CD%\%reponame%"
set "destination=%APPDATA%\PrusaSlicer"

:: If repo folder already exists, remove it before cloning
if exist "%source%" rd /s /q "%source%"

git clone "%remotesource%" "%source%" --quiet || goto :othererror

robocopy "%source%" "%destination%" /mir /move /nfl /ndl /njh /njs /np /xd "%source%\snapshots" >nul

:: Clean leftovers
if exist "%source%" rd /s /q "%source%" >nul 2>&1

echo:
echo ----------------------------------------------------
echo PrusaSlicer Config Updated!
echo ----------------------------------------------------
echo:
echo Starting PrusaSlicer...

start "" "C:\Program Files\Prusa3D\PrusaSlicer\prusa-slicer.exe"
timeout /t 3 >nul
exit /b 0

:giterror
cls
echo:
echo ----------------------------------------------------
echo You need to install Git first!
echo Download: https://git-scm.com/download/win
echo ----------------------------------------------------
echo:
pause
exit /b 1

:repoauthormissing
cls
echo:
echo ----------------------------------------------------
echo You forgot to set your GitHub username in the script.
echo Please change the author and repository names and try again.
echo ----------------------------------------------------
echo:
pause
exit /b 1

:othererror
cls
echo:
echo ----------------------------------------------------
echo An error occurred during git clone.
echo Check network connection or repository visibility.
echo ----------------------------------------------------
echo:
pause
exit /b 1
