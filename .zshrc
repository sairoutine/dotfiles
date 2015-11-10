# SSH Forward
agent="$HOME/.ssh/agent"
if [ -S "$SSH_AUTH_SOCK" ]; then
    case $SSH_AUTH_SOCK in
    /tmp/*/agent.[0-9]*)
        ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
		chmod -R 777 $agent
    esac
elif [ -S $agent ]; then
    export SSH_AUTH_SOCK=$agent
else
    echo "no ssh-agent"
fi

bindkey -e

alias ls='ls --color=auto -aG'

PS1="[${USER}@${HOST%%.*} %1~]%(!.#.$) "

cdls ()
{
	if [ -d $@ ]; then

		pushd $@ >/dev/null
		ls
		if [ -n "$TMUX" ]; then
			local current_path=`pwd`
			local current_dir=`basename $current_path`
			tmux rename-window $current_dir
		fi
	else
		echo "ディレクトリが存在しません"
	fi
}
alias cd="cdls"

export TERM=xterm-256color

tmux-attach()
{
	if [ $(( `ps aux | grep tmux | grep $USER | grep -v grep | wc -l` )) != 0 ]; then
		tmux attach -t myproject
	else
		tmux new -s myproject
	fi
}

#zle -N tmux-attach
#bindkey '^f' tmux-attach
tmux-attach

pecob()
{
    local selected_branch_name="$(git branch | peco | tr -d ' ')"

	if [ -n "$selected_branch_name" ]; then
		git checkout ${selected_branch_name}
	fi
}
pecok()
{
    local kill_process_name="$(ps aux | peco | awk '{print $2}')"

	if [ -n "$kill_process_name" ]; then
		kill -9 ${kill_process_name}
	fi
}
pecod()
{
    local selected_branch_name="$(git branch | peco | tr -d ' ')"

	if [ -n "$selected_branch_name" ]; then
		git branch -D ${selected_branch_name}
	fi
}
cdr()
{
    local dir="$(dirs -v | peco | awk '{print $1}')"

	if [ -n "$dir" ]; then
		pushd +${dir} >/dev/null
		ls
		if [ -n "$TMUX" ]; then
			local current_path=`pwd`
			local current_dir=`basename $current_path`
			tmux rename-window $current_dir
		fi
	fi
}
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history


#-----------------------------
# 補完機能を有効化
#-----------------------------
autoload -Uz compinit
compinit
# 2個以上接続選択肢があった場合プロンプトによる選択を行う
zstyle ':completion:*default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# vcs_infoロード
autoload -Uz vcs_info
# PROMPT変数内で変数参照する
setopt prompt_subst

# VCSの情報を取得するzshの便利関数 vcs_infoを使う
autoload -Uz vcs_info

# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
RPROMPT="%1(v|%F{green}%1v%f|)"

export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

