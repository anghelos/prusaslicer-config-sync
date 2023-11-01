repoauthor="anghelos"
reponame="vanier-prusaslicer-config"
remotesource="https://github.com/"${repoauthor}"/"${reponame}".git"

git clone $remotesource

source=$reponame"/"
destination="~/Library/Application Support/PrusaSlicer"

# Replace contents of destination folder with contents of source folder
rsync -a --delete $source $destination --exclude /snapshots
rm -rf $source