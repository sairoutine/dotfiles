if [ "$(uname)" == 'Darwin' ]; then
	alias ls='ls -aG'
else
	alias ls='ls --color=auto -aG'
fi

PS1="[\u@\h \W]\\$ "

cdls ()
{
	pushd $@ >/dev/null
	ls
	if [ -n "$TMUX" ]; then
		local current_path=`pwd`
		local current_dir=`basename $current_path`
		tmux rename-window $current_dir
	fi
}
alias cd="cdls"

alias e1='sudo tail -F -n20 /var/log/httpd/error_log'

alias tmn="tmux new -s myproject1"
alias tma="tmux attach -t myproject1"
alias tml="tmux list-sessions"
export TERM=xterm-256color

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


if [ -f ~/.bashrc ]; then
       . ~/.bashrc
fi
