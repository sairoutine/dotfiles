alias ls='ls --color=auto -aG'

PS1="[\u@\h \W]\\$ "

cdls ()
{
    \cd "$@" && ls
}
alias cd="cdls"

export TERM=xterm-256color

if [ -f ~/.bashrc ]; then
       . ~/.bashrc
fi
