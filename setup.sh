#!/bin/bash

DIR=$(dirname "$0")
cd "$DIR"

packages=("git" "zsh" "exa")


if [ "$(uname)" == "Darwin" ]; then
    echo "OSX installation started ...."
fi

if [ "$(uname)" == "Linux" ]; then
    echo "Linux installation started ...."
    sudo apt update

    for package in "${packages[@]}"; do
        if ! command -v $package &> /dev/null; then
            echo "$package is not installed. Installing $package..."
            sudo apt install $package -y
            echo "$package has been installed."
        else
            echo "$package is already installed."
        fi
    done
    sudo chsh -s /bin/zsh

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    ZSH_CUSTOM="${ZSH}/plugins"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/zsh-autosuggestions --depth=1
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM}/zsh-syntax-highlighting --depth=1
    git clone git@github.com:grigorii-zander/zsh-npm-scripts-autocomplete.git ${ZSH_CUSTOM}/zsh-npm-scripts-autocomplete --depth=1
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH/custom/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH/themes/spaceship.zsh-theme"
    zsh

    echo "please supply local zshrc file"
    echo "➜ scp -i ~/.ssh/id_rsa_pi.pub ~/.zshrc patfish@raspberrypi.local:~/ "
fi