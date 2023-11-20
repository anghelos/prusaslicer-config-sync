@echo off
set repoauthor=anghelos
set reponame=vanier-prusaslicer-config
set remotesource=https://github.com/%repoauthor%/%reponame%.git

:: Check if git is installed
git version >nul 2>&1 || goto :giterror
git clone %remotesource% || goto:othererror

set source=%CD%/%reponame%
set destination=%appdata%\PrusaSlicer

robocopy %source% %destination% /mir /move /xd %source%\snapshots\

exit /b 0

:giterror
:: Throw error if git is not installed
ECHO: & ECHO -------------- & ECHO: & ECHO You need to install git first! & ECHO: & ECHO -------------- &  ECHO: & PAUSE

exit /b 0

:othererror
:: Throw error if something else went wrong
ECHO: & ECHO -------------- & ECHO: & ECHO Something went wrong! See error above. & ECHO: & ECHO -------------- &  ECHO: & PAUSE
