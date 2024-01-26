############################

# !!! WARNING !!!

# This code is untested, as I figured I needed to install Developer tools on a mac computer to run shell scripts, which defeated my purpose.

############################
repoauthor="YOUR GITHUB USERNAME"
reponame="YOUR GITHUB REPOSITORY NAME"

remotesource="https://github.com/"${repoauthor}"/"${reponame}".git"

# Check if git is installed and throw error if not
if ! [ -x "$(command -v git)" ]; then
  echo '----------
  Error: git is not installed.
  ----------' >&2
  exit 1
fi

git clone $remotesource

source=$reponame"/"
destination="~/Library/Application Support/PrusaSlicer"

# Replace contents of destination folder with contents of source folder
rsync -a --delete $source $destination --exclude /snapshots
rm -rf $source
