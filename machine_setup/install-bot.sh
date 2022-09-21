#!/bin/bash

source ~/bot.sh
NC=$'\e[0;0m'

bot "Hi, I'm the dotfile bot. Here to help setup your machine. Let's get started..."
echo "${NC}"





currentshell=$(basename ${SHELL})
read -p $"Enter the default shell to use? [$currentshell] "  defaultshell

if [[ "$(basename ${SHELL})" != "$defaultshell" ]]; then
    chsh -s $(command -v $defaultshell)
fi


echo ""

read -r -p "Do you want to setup a git config? [Y] " setup_gitconfig

if [[ "${setup_gitconfig^^}" == "Y" ]]; then
    read -r -p "Enter your git username? [$USER] " gitusername
    read -r -p "Enter your git email address? " gitemailaddress

    git config --global user.name "$gitusername"
    git config --global user.email "$gitemailaddress"
fi



LOCALHOSTNAME=$(hostname -s)
COMPUTERNAME=$(hostname -s)
read -p "Enter computer name to use for this machine: [${COMPUTERNAME}] " computername
read -p "Enter local hostname to use for this machine: [${LOCALHOSTNAME}] " localhostname
read -p "Enter hostname to use for this machine: [${HOSTNAME}] " machinehostname

CHANGED=0
if [[  -z $computername ]]; then
    computername=$COMPUTERNAME
    CHANGED=1
fi

if [[ -z $localhostname ]]; then
    localhostname=$LOCALHOSTNAME
    CHANGED=1
fi 

if [[ -z $machinehostname ]]; then
    machinehostname=$HOSTNAME
    CHANGED=1
fi


if [[ $CHANGED != 0 ]]; then
    read -p "Enter sudo user: [root] " sudoer
    read -p "Enter password for user ${sudoer}: " -s sudoer_passwd


    echo "$sudoer_passwd" | sudo -S -u "$sudoer" scutil --set ComputerName "$computername"
    echo "$sudoer_passwd" | sudo -S -u "$sudoer" scutil --set LocalHostName "$localhostname"
    echo "$sudoer_passwd" | sudo -S -u "$sudoer" scutil --set HostName "$machinehostname"
fi

echo ""

bot "Great! Configured machine basics. Time to install your personal dotfiles if avaiable..."
read -p "Enter gitub remote-url for dotfiles repo: [jjbiggins/dot.git]: " remotegitrepo
echo ""


if [[ -z $remotegitrepo ]]; then
	remotegitrepo="https://github.com/jjbiggins/dot.git"
fi


if ! command -v git >/dev/null; then
    echo "ERROR: git not found; git must be installed"
    exit 1
fi


PLATFORM=$(uname -s)
GITCMD=$(command -v git)

DOTFILES_WORK_TREE="${HOME}"
DOTFILES_BARE_REPO="${HOME}/.cfg"
BACKUP_DOTFILE_DIR="${HOME}/.bakup_orig_dotfiles"
DOTFILES_REMOTE_URL="$remotegitrepo"
DOTFILES_TO_BACKUP=($(find ${HOME} -maxdepth 1 -name .\*))


mkdir "${BACKUP_DOTFILE_DIR}"
for dotfile in ${DOTFILES_TO_BACKUP[@]}; do
    mv "$dotfile" "${BACKUP_DOTFILE_DIR}/"
done


"${GITCMD}" clone --bare "$DOTFILES_REMOTE_URL" "${DOTFILES_BARE_REPO}"
"${GITCMD}" config --local status.showUntrackedFiles no    

"${GITCMD}" \
    --git-dir="${DOTFILES_BARE_REPO}" \
    --work-tree="${DOTFILES_WORK_TREE}" \
    checkout


sh $HOME/.macos.sh
killall Dock.app
killall Finder.app




bot "Dotfiles Installed SUCCESSFULLY"

bot "may need to restart machine for all changes to take place"







