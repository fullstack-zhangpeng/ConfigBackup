#!/bin/bash

argv0=$(echo "$0" | sed -e 's,\\,/,g')
echo ${argv0}
work_path="$( cd "$( dirname "$argv0" )" && pwd )";
echo "当前工作目录为：${work_path}";

# Close any open System Preferences panes, to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'
# Ask for the administrator password upfront
sudo -v


# ----- iTerm -----
# Don’t display the annoying prompt when quitting iTerm
# defaults write com.googlecode.iterm2 PromptOnQuit -bool false

