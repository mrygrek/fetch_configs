#!/bin/sh

# Main git repo
CONFIGS_REPO='https://git.gitorious.org/configs/configs.git'
# Secondary git repo
#CONFIGS_REPO='https://github.com/mrygrek/dotfiles.git'
# Temporary directory to clone configs into
TMP_CONFIGS=/tmp/configs.git
# Directory where configs are stored - $HOME
CONFIGS_HOME=$HOME

# Do some availability checks
# check if git executable is available
which git 1>/dev/null || { echo "git not found"; exit 1; }
# check if $TMP_CONFIGS already exists
[[ ! -d $TMP_CONFIGS ]] || { echo "directory $TMP_CONFIGS should not exist to run this script properly"; exit 1; }

# fetch configs from the repository into temporary directory 
# because git cannot clone into non-empty directory
echo "Configs are fetched from $CONFIGS_REPO"
git clone --no-checkout $CONFIGS_REPO $TMP_CONFIGS || exit 1

# move git repo to destination directory and remove temporary one
mv $TMP_CONFIGS/.git $CONFIGS_HOME
rm -rf $TMP_CONFIGS && echo "temporary $TMP_CONFIGS deleted"

# in destination directory restore files from git repo 
cd $CONFIGS_HOME
git reset --hard HEAD && echo "configs have been stored in $CONFIGS_HOME"

# create directories needed for Vim temp files storage
mkdir -p $CONFIGS_HOME/.vim/{tmp,backup}
