#!/bin/bash

echo "================================================================="
echo "This script assumes that you have zsh, oh-my-zsh, tmux installed"
echo "================================================================="
echo
echo

DEFAULT_BACKUP_DIR="$(pwd)/backup/"

declare approve
read -p "Backup old files? (y/n) " approve
if [[ "${approve}" =~ "y" ]]; then
    declare backup_dir
    read -p "Update backup location? (${DEFAULT_BACKUP_DIR}) " backup_dir
    if [ -z "${backup_dir}" ]; then
        backup_dir=${DEFAULT_BACKUP_DIR}
    fi

    mkdir ${backup_dir}
    cp ~/.zshrc ${backup_dir} || 1
    cp ~/.bashrc ${backup_dir} || 1
    cp ~/.gitconfig ${backup_dir} || 1
    cp ~/.nanorc ${backup_dir} || 1
    cp ~/.tmux.conf ${backup_dir} || 1
    cp -r ~/.tmux-custom ${backup_dir} || 1
    cp -r ~/.prettierrc ${backup_dir} || 1
    cp ~/.config/starship.toml ${backup_dir} || 1
fi

ln -is $(readlink -f bashrc) ~/.bashrc
ln -is $(readlink -f zshrc) ~/.zshrc
ln -is $(readlink -f gitconfig) ~/.gitconfig
ln -is $(readlink -f nanorc) ~/.nanorc
ln -is $(readlink -f prettierrc) ~/.prettierrc
ln -is $(readlink -f tmux.conf) ~/.tmux.conf
ln -is $(readlink -f tmux-custom) ~/tmux-custom
ln -is $(readlink -f starship.toml) ~/.config/starship.toml
mv ~/tmux-custom ~/.tmux-custom
