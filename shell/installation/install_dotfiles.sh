#!/bin/bash
# -----------------------
# ENVVARS
# ----------------------
PLATFORM=$(uname -s)
GIT_BARE_REPO=$HOME/.cfg
LOGSDIR=$HOME/.logs

config () {
	/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME
}

mkdir -p $HOME/.logs/
logfile=$HOME/.logs/install_dotfiles.log


git clone --bare "https://github.com/jjbiggins/dot.git" "$HOME/.cfg" >> $logfile
while kill -0 $BACK_PID; do
	echo "Process: git clone is still active..."
	sleep 3
done

if [[ $PLATFORM == "Linux" ]]; then
	branch=linux
elif [[ $PLATFORM == "Darwin" ]]; then
	branch=macbook
fi

FILES=($(cd .cfg; git ls-tree -r "$branch" --name-only; cd $HOME))
EXISTING_DOT_FILES=$(find . -maxdepth 1 -name '.*' -exec basename {} \;)
echo ${FILES[@]}
for file in ${FILE[@]}
do
	if [[ "$file" =~ "${EXISTING_DOT_FILES[@]}" ]]; then
		rm -rf "$file"
	fi
done

config checkout "$branch"
echo "Dotfiles Installed" 
