# alias gdb='gdb -tui'
alias cls 'clear'              # 用 cls 清屏
alias ll 'ls -lh'              # 模拟 Bash 的 ll
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!

set -x PATH $PATH /mnt/c/Windows

if test -f /home/mx2004/miniconda3/bin/conda
    eval /home/mx2004/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/mx2004/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/mx2004/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/mx2004/miniconda3/bin" $PATH
    end
end

set -x EDITOR nvim
set -x http_proxy http://172.17.144.1:7897
set -x https_proxy http://1.1.1.1:7897
starship init fish | source

# <<< conda initialize <<<
#pyenv init - fish | source
#set -x PATH /home/mx2004/.local/bin $PATH
set -U fish_user_paths $fish_user_paths /home/mx2004/bin

# 允许 Zed 在模拟 GPU 环境下运行
set -gx ZED_ALLOW_EMULATED_GPU 1

# 解决 Wayland 显示问题，设置 WAYLAND_DISPLAY 为空
# 这会创建一个名为 'zed' 的函数（在 Fish 中类似别名），当你输入 zed 时会执行
function zed --description 'Launch Zed with Wayland display workaround'
    env WAYLAND_DISPLAY='' zed $argv
end

zoxide init fish | source
fzf_key_bindings

# Modern replacements
alias ls 'eza --icons'
alias cat 'batcat'