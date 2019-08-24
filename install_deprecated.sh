#!/bin/bash

argv0=$(echo "$0" | sed -e 's,\\,/,g')
echo ${argv0}
work_path="$( cd "$( dirname "$argv0" )" && pwd )";
echo "当前工作目录为：${work_path}";

Tools(){
    # yum install -y python git wget curl zsh
    echo "🎉🎉🎉 tools plugin installed!"
}

oh_my_zsh(){
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo "🎉🎉🎉 oh my zsh installed!"
}

plugin(){
    # #安装 oh-my-zsh 插件
    #zsh-autosuggestions, 命令提示插件
    path=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    # rm -rf $path
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    #zsh-syntax-highlighting, 命令高亮插件
    path=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    # rm -rf $path
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo "🎉🎉🎉 oh my zsh plugin installed!"
}

#修改脚本.zshrc
modify_zshrc(){
    #编译.bash_profile
    firstline=$(head -1 ~/.zshrc)
    if [[ $firstline != "source .bash_profile" ]];
    then
        sed -i "" '1i\
        source .bash_profile
        ' ~/.zshrc
    fi

    head='plugins=('
    middleArray=("git" "z" "zsh-autosuggestions" "zsh-syntax-highlighting")
    tail=')'

    middle=$(for value in ${middleArray[@]};do echo $value" ";done)
    middle=${middle%,*}

    target=$(echo $head$middle$tail)

    #-i ：直接修改读取的文件内容，而不是输出到终端。
    # sed -i 's/^plugins=(.*)$/${head}${middle}${tail}/g' ~/.zshrc
    sed -i "" "s/^plugins=(.*)$/$target/g" ~/.zshrc 
    # > ~/zshrc1

    echo "🎉🎉🎉 .zshrc modified!"
}

main(){
    Tools
    oh_my_zsh
    plugin
    modify_zshrc
}

main
