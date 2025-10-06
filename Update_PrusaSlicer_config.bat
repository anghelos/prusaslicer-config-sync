mode con: cols=60 lines=16
mode con: cols=60 lines=16
@echo off
echo:
Set "prusaslicer=prusa-slicer.exe"
tasklist /NH /FI "imagename eq %prusaslicer%" 2>nul |find /i "%prusaslicer%" >nul
If errorlevel 1 (goto :update)
Echo PrusaSlicer is running. Please close it or press any key to kill it.
PAUSE
tasklist /NH /FI "imagename eq %prusaslicer%" 2>nul |find /i "%prusaslicer%" >nul
if not errorlevel 1 (taskkill /IM prusa-slicer.exe /F)

:update
echo:
echo Updating Prusaslicer Config

set repoauthor=YOUR GITHUB USERNAME
set reponame=YOUR GITHUB REPOSITORY NAME

:: Check if repoauthor has been set
IF NOT "%repoauthor%"=="%repoauthor:YOUR GITHUB USERNAME=%" (
    goto:repoauthormissing
)

set remotesource=https://github.com/%repoauthor%/%reponame%.git

:: Check if git is installed
git version >nul 2>&1 || goto :giterror
git clone %remotesource% --quiet || goto:othererror

set source=%CD%/%reponame%
set destination=%appdata%\PrusaSlicer

robocopy %source% %destination% /mir /move /xd %source%\snapshots\
echo:
echo:
ECHO: & ECHO -------------- & ECHO: & ECHO PrusaSlicer Config Updated! & echo: & ECHO -------------- & echo:


echo:
echo Starting PrusaSlicer
echo:
echo:
echo:
start "" /b "C:/Program Files/Prusa3D/PrusaSlicer/prusa-slicer.exe"

timeout /t 3

exit /b 0

:giterror
:: Throw error if git is not installed
ECHO: & ECHO -------------- & ECHO: & ECHO You need to install git first! & ECHO: & ECHO You can download it here: https://git-scm.com/download/win & ECHO -------------- &  ECHO: & PAUSE

exit /b 0

:othererror
:: Throw error if something else went wrong
ECHO: & ECHO -------------- & ECHO: & ECHO Something went wrong! See error above. & ECHO: & ECHO -------------- &  ECHO: & PAUSE

exit /b 0

:repoauthormissing
:: Throw error if repoauthor has not been set
ECHO: & ECHO -------------- & ECHO: & ECHO You forgot to set your GitHub username in the script. & ECHO Please change the author and repository names and try again. & ECHO: & ECHO -------------- &  ECHO: & PAUSE