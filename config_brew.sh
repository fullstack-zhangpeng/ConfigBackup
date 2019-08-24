#!/bin/bash

# Install packages
install_plugins(){
	packages=(
    	# cmake
    	git
    	git-flow
    	vim
    	tree
    	python
    	ctags
	)
	brew install "${packages[@]}"

    echo "🎉🎉🎉 brew packages installed!"
}

main(){
    install_plugins
}

main
