# 告诉系统其后路径所指定的程序即是解释此脚本文件的 Shell 程序。
#!/bin/bash

command_exists() {
	command -v "$@" >/dev/null 2>&1
}

step() {
    echo ${BLUE}"[Step$1]: $2"${RESET} >&2
}

success() {
	echo ${GREEN}"[Success]: $@"${RESET} >&2
}

error() {
	echo ${RED}"[Error]: $@"${RESET} >&2
}

warning() {
	echo ${YELLOW}"[Warning]: $@"${RESET} >&2
}

setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

# 安装 oh-my-zsh
setup_ohmyzsh(){
    if [ -d "$ZSH" ]; then
        warning "Oh my ZSH already exists, skip the installation step..."
        return
    fi
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "🎉🎉🎉 oh my zsh installed!"
}

cloneOrUpdatePlugin(){
    # 第一个参数为插件名字
    localPath=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$1
    # 第二个参数为仓库地址
    respority=$2
    
    if [ -d ${localPath} ] && [ -d "${localPath}/.git" ];then
        # 存在test以及test中的.git，则认为test库曾经被拉到本地
        cd ${localPath}
        git reset --hard HEAD
        git pull
        # cd ..
    else
        #如果不存在，则需要clone
        git clone ${respority} ${localPath}
    fi
}

backup_old_ohmyzsh_config(){
    echo "${BLUE}Looking for an existing zsh config...${RESET}"
	if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
		OLD_ZSHRC="${HOME}/.zshrc.backup-$(date +%Y-%m-%d_%H-%M-%S)"
		echo "${YELLOW}Found ~/.zshrc.${RESET} ${GREEN}Backing up to ${OLD_ZSHRC}${RESET}"
		cp ${HOME}/.zshrc "$OLD_ZSHRC"
	fi
}

setup_ohmyzsh_plugins(){
    step 2.1 "下载 Oh my ZSH 插件"
    # zsh-autosuggestions
    cloneOrUpdatePlugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git
    # zsh-syntax-highlighting
    cloneOrUpdatePlugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git

    success "Plug-in installation complete..."

    step 2.2 "检查是否已经存在 .zshrc 文件，有则备份"
    backup_old_ohmyzsh_config

    step 2.3 "修改 .zshrc 文件，将插件填入对应位置"
    head='plugins=('
    # built-in plugins
    builtInPlugins=(git z)
    # custom plugins
    customPlugins=(zsh-autosuggestions zsh-syntax-highlighting)
    tail=')'
    
    result=$(echo ${head}${builtInPlugins[*]} ${customPlugins[*]}${tail})

    #-i ：直接修改读取的文件内容，而不是输出到终端。
    sed -i "" "s/^plugins=(.*)$/${result}/g" ~/.zshrc

    success "🎉🎉🎉 .zshrc modified!"
}

main() {
    echo "install begin"
    # argv0=$(echo "$0" | sed -e 's,\\,/,g')
    # # echo ${argv0}
    # work_path="$( cd "$( dirname "$argv0" )" && pwd )";
    # echo "当前工作目录为：${work_path}";

    # # 设置命令行输出颜色
    # setup_color

    # # 安装 ohmyzsh
    # step 1 "安装 Oh my ZSH"
    # setup_ohmyzsh

    # # 安装 ohmyzsh 插件
    # step 2 "安装 Oh my ZSH 插件"
    # setup_ohmyzsh_plugins

    # step 3 "执行 .zshrc 文件"
    # source ~/.zshrc

    # success 脚本执行完毕
    
    # cd ${work_path}
}

main