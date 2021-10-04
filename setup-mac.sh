#!/bin/bash

# Hide "last login" line when starting a new terminal session
echo 'Hide last Login'
echo '-----------------'
touch $HOME/.hushlogin

# Check for Homebrew,
# Install if we don't have it
echo 'Checking if Hombrew is installed and if not installing it'
echo '-----------------'
if test ! $(which brew); then
  echo "Installing homebrew..."1
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Run Doctor
brew doctor

# Update homebrew recipes
brew update

# Upgrade any already installed formulae
brew upgrade

# Install all our dependencies with bundle (See Brewfile)
brew bundle

## NVM / NPM Config
mkdir $HOME/.nvm
echo 'export NVM_DIR=$HOME/.nvm' >>! $HOME/.zshrc
echo '[ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"' >>! $HOME/.zshrc  # This loads nvm
echo '[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"' >>! $HOME/.zshrc  # This loads nvm bash_completion

## Pyen config
echo 'eval "$(pyenv init --path)"' >> ~/.zshrc

## creating folders
mkdir $HOME/screenshots
mkdir $HOME/.dotfiles
mkdir $HOME/repos

source .macos
