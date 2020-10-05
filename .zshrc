bindkey -e

###############################################
# export
###############################################

export TERM=xterm-256color
export EDITOR=vim        # エディタをvimに設定
# 文字コードをUTF-8に設定
export LC_CTYPE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export KCODE=u           # KCODEにUTF-8を設定

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=1000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

###############################################
# その他
###############################################

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

# ls のカラーをOS毎に変更
case "${OSTYPE}" in
darwin*)
	export LSCOLORS=gxfxcxdxbxegedabagacad
	alias ls="clear && ls -aG"
	;;
linux*)
	alias ls='clear && ls --color=auto -aG'
	;;
esac

# macOS のみ、d でデスクトップへ
case "${OSTYPE}" in
darwin*)
	alias d='cd ~/Desktop'
	;;
esac

###############################################
# alias
###############################################

# typo
alias g='git'
alias gi='git'
alias gti='git'
alias v='vim'
alias vi='vim'

# macの背景色変更
alias chbg='~/dotfiles/chbg'

###############################################
# global alias
###############################################

# B ブランチ一覧
alias -g B='`git branch | peco | tr -d " "`'

# M 変更ファイル一覧
alias -g M='`git status -s | egrep "^ +[MA]" | awk "{print\\$2}" | peco`'

# D 配下のディレクトリ一覧
alias -g D='$(find ./ -path "*/\.*" -name .git -prune -o -type d -print 2> /dev/null | peco)'
# F 配下のファイル一覧
alias -g F='$(find ./ -path "*/\.*" -name .git -prune -o -type f -print 2> /dev/null | peco)'

###############################################
# suffix alias
###############################################

alias -s gz='tar -xzvf' # ./hoge.tar.gz で展開できる
alias -s html='open' # ./index.html でブラウザで開く
# alias -s {mp3,mp4,wav,mkv,m4v,m4a,wmv,avi,mpeg,mpg,vob,mov,rm}='mplayer' # こんな定義も可能

###############################################
# zsh function
###############################################

# git のレポジトリどれかに移動
function root () {
	cd $(ghq root)/$(ghq list | peco)
}

# git のルートディレクトリに移動
function root () {
	cd `git rev-parse --show-toplevel`
}

# countsource 拡張子でカレントディレクトリを再帰的にソースコード行数を数える
function countsource () {
	find . -name "*."$1 | xargs wc -l
}

# notify で完了を Mac に通知
function notify() {
	terminal-notifier -message done
}



###############################################
# key bind
###############################################

# Ctrl+f で tmux にアタッチ or tmux 作成
function tmux-attach() {
    # Launching tmux inside a zle widget is not easy
    # Hence, We delegate the work to the parent zsh
    BUFFER=" { tmux list-sessions >& /dev/null && tmux attach -t $(tmux list-sessions | peco | awk -F':' '{print $1}') } || tmux new -s $RANDOM"
    zle accept-line
}
zle -N tmux-attach
bindkey '^f' tmux-attach

# Ctrl+r で command history
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

# Ctrl+u で一つ上のディレクトリに移動
function cdup() {
   echo
   cd ..
   zle reset-prompt
}
zle -N cdup
bindkey '^u' cdup

###############################################
# zsh 設定
###############################################

# 補完機能を有効化
autoload -Uz compinit
compinit
# 2個以上接続選択肢があった場合プロンプトによる選択を行う
zstyle ':completion:*default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

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
#RPROMPT="%1(v|%F{green}%1v%f|)[%F{red}%B%d%f%b]"
RPROMPT="%1(v|%F{green}%1v%f|)"

#PROMPT='$ '
PROMPT='($?)[%C] '

setopt auto_cd

# 移動後にls
# zshではchpwd関数を定義することで、ディレクトリ移動後に任意のコマンドを実行することができます。
function chpwd() { ls }

# 重複を記録しない
setopt hist_ignore_dups

# 開始と終了を記録
setopt EXTENDED_HISTORY

# historyの共有
setopt share_history

## cd 時に自動で push
setopt auto_pushd

## 同じディレクトリを pushd しない
setopt pushd_ignore_dups

###############################################
# .zshrc.local があればそれを読む
###############################################
[ -f ~/.zshrc.local ] && source ~/.zshrc.local


