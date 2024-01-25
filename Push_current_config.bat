@echo off

set repoauthor=YOUR GITHUB USERNAME
set reponame=YOUR GITHUB REPOSITORY NAME

:: Check if repoauthor has been set
IF NOT "%repoauthor%"=="%repoauthor:YOUR GITHUB USERNAME=%" (
    goto:repoauthormissing
)

set remotesource=https://github.com/%repoauthor%/%reponame%.git

:: Check if git is installed
git version >nul 2>&1 || goto :giterror

cd %appdata%\PrusaSlicer || goto :othererror

IF NOT EXIST ".gitignore" (
    echo .gitignore not found, creating one...
    :: create .gitignore file with some default entries
    echo *.bak >> .gitignore
    echo /snapshots >> .gitignore
    echo PrusaSlicerGcodeViewer* >> .gitignore
)

IF NOT EXIST ".git" (
    echo .git folder not found, initializing repository...
    git init || goto :othererror
    git remote add origin %remotesource% || goto :othererror
)

git add .
git commit -m "Update config with batch shortcut"
git push -u origin main

ECHO: & ECHO -------------- & ECHO: & ECHO Done! & ECHO: & ECHO -------------- &  ECHO: & PAUSE 

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