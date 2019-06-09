#!/bin/bash

# Install Homebrew
if  command -v brew > /dev/null; then
    # Make sure we’re using the latest Homebrew.
    brew update
    # Upgrade any already-installed formulae.
    brew upgrade
    # Remove stale lock files and outdated downloads for formulae and casks, and remove old versions of installed formulae.
    brew cleanup
else
    echo | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install packages
packages=(
    # cmake
    git
    git-flow
    vim
    tree
    python
)
brew install "${packages[@]}"