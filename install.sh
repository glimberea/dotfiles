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

    mkdir -p ${backup_dir}/zsh-scripts
    cp ~/.zshrc ${backup_dir} || true
    cp ~/.bashrc ${backup_dir} || true
    cp ~/.gitconfig ${backup_dir} || true
    cp ~/.nanorc ${backup_dir} || true
    cp ~/.tmux.conf ${backup_dir} || true
    cp -r ~/.tmux-custom ${backup_dir} || true
    cp ~/.prettierrc ${backup_dir} || true
    cp ~/.config/starship.toml ${backup_dir} || true
    cp ~/.oh-my-zsh/custom/*.zsh ${backup_dir}/zsh-scripts || true
    cp -r ~/.bash-scripts ${backup_dir} || true
fi

ln -is $(readlink -f bashrc) ~/.bashrc
ln -is $(readlink -f zshrc) ~/.zshrc
ln -is $(readlink -f gitconfig) ~/.gitconfig
ln -is $(readlink -f nanorc) ~/.nanorc
ln -is $(readlink -f prettierrc) ~/.prettierrc
ln -is $(readlink -f tmux.conf) ~/.tmux.conf
ln -is $(readlink -f tmux-custom) ~/tmux-custom
ln -is $(readlink -f bash-scripts) ~/bash-scripts
ln -is $(readlink -f starship.toml) ~/.config/starship.toml
mv ~/tmux-custom ~/.tmux-custom
mv ~/bash-scripts ~/.bash-scripts

for file in $(ls ./zsh-scripts); do
    ln -is $(readlink -f "zsh-scripts/$file") ~/.oh-my-zsh/custom
done
