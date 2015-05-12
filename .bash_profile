if [ "$(uname)" == 'Darwin' ]; then
	alias ls='ls -aG'
else
	alias ls='ls --color=auto -aG'
fi

PS1="[\u@\h \W]\\$ "

cdls ()
{
	pushd `pwd` >/dev/null
    \cd "$@" && ls
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
if [ $SHLVL = 1 ]; then
     tma
fi

export TERM=xterm-256color

if [ -f ~/.bashrc ]; then
       . ~/.bashrc
fi
