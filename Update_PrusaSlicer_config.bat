set repoauthor=anghelos
set reponame=vanier-prusaslicer-config
set remotesource=https://github.com/%repoauthor%/%reponame%.git

git clone %remotesource%

set source=%CD%/%reponame%
set destination=%appdata%\PrusaSlicer

robocopy %source% %destination% /mir /move
