#!/bin/bash


if ! command -v git >/dev/null; then
    echo "ERROR: git not found; git must be installed"
    exit 1
fi

PLATFORM=$(uname -s)
GITCMD=$(command -v git)

DOTFILES_WORK_TREE="${HOME}"
DOTFILES_BARE_REPO="${HOME}/.cfg"
BACKUP_DOTFILE_DIR="${HOME}/.bakup_orig_dotfiles"
DOTFILES_REMOTE_URL="https://github.com/jjbiggins/dot.git"
DOTFILES_TO_BACKUP=($(find ${HOME} -maxdepth 1 -name .\*))


if [[ "${PLATFORM}" == "Darwin" ]]; then
    BRANCH=macbook
elif [[ "${PLATFORM}" == "Linux" ]]; then
    BRANCH=linux
else
    BRANCH=master
fi



mkdir "${BACKUP_DOTFILE_DIR}"
for dotfile in ${DOTFILES_TO_BACKUP[@]}; do
    mv "$dotfile" "${BACKUP_DOTFILE_DIR}/"
done


"${GITCMD}" clone --bare "$DOTFILES_REMOTE_URL" "${DOTFILES_BARE_REPO}"

"${GITCMD}" \
    --git-dir="${DOTFILE_BARE_REPO}" \
    --work-tree="${DOTFILES_WORK_TREE}" \
    checkout -b "${BRANCH}"



