if [ "$(uname)" == 'Darwin' ]; then
	alias ls='ls -aG'
else
	alias ls='ls --color=auto -aG'
fi

PS1="[\u@\h \W]\\$ "

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

alias e1='sudo tail -F -n20 /var/log/httpd/error_log'

export TERM=xterm-256color

if [[ $TMUX ]]; then source ~/dotfiles/tmux-git.sh; fi

tmux-attach()
{
	if [ $(( `ps aux | grep tmux | grep $USER | grep -v grep | wc -l` )) != 0 ]; then
		tmux attach -t myproject
	else
		tmux new -s myproject
	fi
}
bind -x '"\C-f": tmux-attach'

peco-branch()
{
    local selected_branch_name="$(git branch | peco | tr -d ' ')"

	if [ -n "$selected_branch_name" ]; then
		git checkout ${selected_branch_name}
	fi
}
peco-kill()
{
    local kill_process_name="$(ps aux | peco | awk '{print $2}')"

	if [ -n "$kill_process_name" ]; then
		kill -9 ${kill_process_name}
	fi
}
peco-deletebranch()
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
peco-select-history() {
    declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
bind -x '"\C-r": peco-select-history'

# SSH Forward
chmod -R 777 $(dirname $SSH_AUTH_SOCK)

if [ -f ~/.bashrc ]; then
       . ~/.bashrc
fi
