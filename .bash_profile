alias ls='ls -aG'

PS1="[\u@\h \W]\\$ "


export TERM=xterm-256color

if [ -f ~/.bashrc ]; then
       . ~/.bashrc
fi
