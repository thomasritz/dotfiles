#! /bin/zsh

if [ x"$HOME" = x ] ; then
        export HOME=$(cd ~ ; pwd)
fi

if [ x"$HOSTNAME" = x ] ; then
        export HOSTNAME=$(hostname)
fi

export GREP_OPTIONS="--color"
export EDITOR=vim
export VISUAL=vim
export LESS="-R -M --shift 5"

if [ $UID -eq 0 ]; then
        PATH=~root/bin:$PATH
else
        PATH="${HOME}/bin:${PATH}"
fi
export PATH

# this makes man pages look nicer...
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
