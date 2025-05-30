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



# <<< conda initialize <<<
#pyenv init - fish | source
#set -x PATH /home/mx2004/.local/bin $PATH
set -U fish_user_paths $fish_user_paths /home/mx2004/bin
