alias ls='ls -aG'

PS1="[\u@\h \W]\\$ "

cdls ()
{
    \cd "$@" && ls -a
}
alias cd="cdls"

export TERM=xterm-256color

if [ -f ~/.bashrc ]; then
       . ~/.bashrc
fi
