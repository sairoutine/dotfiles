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

case "${OSTYPE}" in
darwin*)
	export LSCOLORS=gxfxcxdxbxegedabagacad
	alias ls="ls -aG"
	;;
linux*)
	alias ls='ls --color=auto -aG'
	;;
esac

alias g='git'
alias v='vim'
alias vi='vim'

# macの背景色変更
alias chbg='~/dotfiles/chbg'

PS1="[${USER}@${HOST%%.*} %1~]%(!.#.$) "

# 移動後にls
function chpwd() { ls }


export TERM=xterm-256color

function tmux-attach() {
    # Launching tmux inside a zle widget is not easy
    # Hence, We delegate the work to the parent zsh
    BUFFER=" { tmux list-sessions >& /dev/null && tmux attach } || tmux new -s myproject"
    zle accept-line
}
zle -N tmux-attach
bindkey '^f' tmux-attach
#tmux-attach

pecoa()
{
	local file="$(git status -s | egrep '^ +[MA]' | awk '{print$2}' | peco)"

	if [ -n "$file" ]; then
		git add ${file}
	fi
}

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
	local file="$(git status -s | egrep '^ +[MA]' | awk '{print$2}' | peco)"

	if [ -n "$file" ]; then
		git diff ${file}
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
PROMPT='[%C] '


export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定

setopt auto_cd
function chpwd() { ls }

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=1000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# 重複を記録しない
setopt hist_ignore_dups

# 開始と終了を記録
setopt EXTENDED_HISTORY

## cd 時に自動で push
setopt auto_pushd

## 同じディレクトリを pushd しない
setopt pushd_ignore_dups

# bd.zsh start
bd () {
  (($#<1)) && {
    print -- "usage: $0 <name-of-any-parent-directory>"
    print -- "       $0 <number-of-folders>"
    return 1
  } >&2
  # example:
  #   $PWD == /home/arash/abc ==> $num_folders_we_are_in == 3
  local num_folders_we_are_in=${#${(ps:/:)${PWD}}}
  local dest="./"

  # First try to find a folder with matching name (could potentially be a number)
  # Get parents (in reverse order)
  local parents
  local i
  for i in {$((num_folders_we_are_in+1))..2}
  do
    parents=($parents "$(echo $PWD | cut -d'/' -f$i)")
  done
  parents=($parents "/")
  # Build dest and 'cd' to it
  local parent
  foreach parent (${parents})
  do
    if [[ $1 == $parent ]]
    then
      cd $dest
      return 0
    fi
    dest+="../"
  done

  # If the user provided an integer, go up as many times as asked
  dest="./"
  if [[ "$1" = <-> ]]
  then
    if [[ $1 -gt $num_folders_we_are_in ]]
    then
      print -- "bd: Error: Can not go up $1 times (not enough parent directories)"
      return 1
    fi
    for i in {1..$1}
    do
      dest+="../"
    done
    cd $dest
    return 0
  fi

  # If the above methods fail
  print -- "bd: Error: No parent directory named '$1'"
  return 1
}
_bd () {
  # Get parents (in reverse order)
  local num_folders_we_are_in=${#${(ps:/:)${PWD}}}
  local i
  for i in {$((num_folders_we_are_in+1))..2}
  do
    reply=($reply "`echo $PWD | cut -d'/' -f$i`")
  done
  reply=($reply "/")
}
compctl -V directories -K _bd bd
# bd.zsh end


function cdup() {
   echo
   cd ..
   zle reset-prompt
}
zle -N cdup
bindkey '^u' cdup

# enhancd
source ~/dotfiles/enhancd/init.sh

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

