#!/bin/bash

setupDevEnv() {
    # 创建工作空间
    mkdir ~/Desktop/workspace
    # 创建私人文件夹
    mkdir ~/Desktop/zhangpeng
}

bashProfile() {
    ln -s customBashProfile ~/.bash_profile
    ln -s customVimrc ~/.vimrc 
}

sshkey() {
    # 生成 SSH Key
    ssh-keygen -t rsa -C "zhangpeng.0304@aliyun.com"
    # 复制到剪贴板
    cat ~/.ssh/id_rsa.pub | pbcopy
    echo "🎉🎉🎉 ssh-key copied!"
}

main() {
   setupDevEnv
#   sshkey 
}

main
