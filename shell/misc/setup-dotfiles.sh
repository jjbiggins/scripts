#!/bin/bash

remote_dotfiles=https://github.com/jjbiggins/dot.git
bare_repo=$HOME/.cfg

git clone --bare "$remote_dotfiles" "$bare_repo"

config ()
{
	/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
config checkout linux

mkdir -p .dotfile-backup
if [[ "$OSTYPE" =~ "linux" ]]; then
	branch=linux
	config checkout linux
elif [[ "$OSTYPE" =~ "darwin" ]]; then
	branch=macbook
	config checkout macbook
fi

if [ $? == 0 ]; then
	echo "Checked out config.";
else
	echo "Backing up pre-existing dotfiles........"
	config checkout "$branch" 2>&1 | egrep '^\s+\.' | awk '{print $1}' | xargs -I{} mv $HOME/{} "$HOME/.dotfile-backup/{}"
fi;
config checkout "$branch"
config config status.showUntrackedFiles no

exec $SHELL
source ~/.bash_profile
