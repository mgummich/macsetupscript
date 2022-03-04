#!/bin/bash

# Hide "last login" line when starting a new terminal session
echo 'Hide last Login'
echo '-----------------'
touch $HOME/.hushlogin

install_rosetta() {
    sudo softwareupdate --install-rosetta
}

install_brew() {
    if ! command -v "brew" &> /dev/null; then
        printf "Homebrew not found, installing."
        # install homebrew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # set path
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    printf "Installing homebrew packages..."
    brew update
    # Upgrade any already installed formulae
    brew upgrade
    brew bundle
    brew doctor
}

create_dirs() {
    declare -a dirs=(
        "$HOME/screenshots"
        "$HOME/.dotfiles"
        "$HOME/repos"
    )

    for i in "${dirs[@]}"; do
        mkdir "$i"
    done
}

build_xcode() {
    if ! xcode-select --print-path &> /dev/null; then
        xcode-select --install &> /dev/null

        until xcode-select --print-path &> /dev/null; do
            sleep 5
        done

        sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

        sudo xcodebuild -license
    fi
}

## NVM / NPM Config
mkdir $HOME/.nvm
echo 'export NVM_DIR=$HOME/.nvm' >>! $HOME/.zshrc
echo '[ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"' >>! $HOME/.zshrc  # This loads nvm
echo '[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"' >>! $HOME/.zshrc  # This loads nvm bash_completion

## Pyen config
echo 'eval "$(pyenv init --path)"' >> ~/.zshrc

printf "🌈  Installing Rosetta\n"
install_rosetta

printf "🗄  Creating directories\n"
create_dirs

printf "🛠  Installing Xcode Command Line Tools\n"
build_xcode

printf "🍺  Installing Homebrew packages\n"
install_brew

source .macos

printf "✨  Done!\n"