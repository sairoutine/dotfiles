if [ "$(uname)" == 'Darwin' ]; then
	alias ls='ls -aG'
else
	alias ls='ls --color=auto -aG'
fi

PS1="[\u@\h \W]\\$ "

cdls ()
{
    \cd "$@" && ls
	if [ -n $TMUX ]; then
		local current_path=`pwd`
		local current_dir=`basename $current_path`
		tmux rename-window $current_dir
	fi
}
alias cd="cdls"

export TERM=xterm-256color

if [ -f ~/.bashrc ]; then
       . ~/.bashrc
fi
