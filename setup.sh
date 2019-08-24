#!/bin/bash

brew(){
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "🎉🎉🎉 brew installed!"
}


iTerm2(){
    # yum install -y python git wget curl zsh
    curl -O https://iterm2.com/downloads/stable/iTerm2-3_2_9.zip
    unzip iTerm2-3_2_9.zip
    mv iTerm.app/ /Applications/iTerm.app/
    echo "🎉🎉🎉 iTerm2 installed!"
}

oh_my_zsh(){
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo "🎉🎉🎉 oh my zsh installed!"
}

main(){
    brew
    iTerm2
    oh_my_zsh
}

# 安装软件
main
