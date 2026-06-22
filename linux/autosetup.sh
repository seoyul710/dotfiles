#!/bin/bash

echo "installing environment..."

sudo apt update

sudo apt install -y \
gcc \
g++ \
make \
gdb \
git \
vim \
python3 \
python3-pip \
python3-venv \
curl \
wget \
file \
xxd \
zsh \
zsh-autosuggestions \
zsh-syntax-highlighting \
fastfetch \
imagemagick \
kitty-terminfo

# zsh default shell
sudo chsh -s $(which zsh) $USER

# starship install
curl -sS https://starship.rs/install.sh | sh

# config folders
mkdir -p ~/.config
mkdir -p ~/.config/kitty

# dotfiles copy
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cp "$SCRIPT_DIR/.zshrc" ~/
cp "$SCRIPT_DIR/kitty.conf" ~/.config/kitty/kitty.conf
"$SCRIPT_DIR/switch-profile.sh" apply default

echo "done. relog required"
