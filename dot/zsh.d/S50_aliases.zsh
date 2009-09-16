#!/bin/zsh

unalias -m '*'

autoload zmv
alias mmv='noglob zmv -W'

alias :q='exit'
alias :e='vim'
alias :n='vim'

case "${OSTYPE}" in
  freebsd*|darwin*)
  alias ls="ls -G -w -F"
  ;;
  linux*)
  alias ls="ls --color=auto -F"
  ;;
esac

alias l='ls -l'
alias la='ls -la'
alias lh='ls -lh'
alias lsd='ls -ld *(-/DN)'      # List only dirs and symlinks that point to dirs
alias lsa='ls -ld .*'           # List only file beginning with "."
alias mv='nocorrect mv'         # no spelling correction on mv
alias cp='nocorrect cp'         # no spelling correction on cp
alias mkdir='nocorrect mkdir'   # no spelling correction on mkdir
alias -- +=pushd
alias -- -=popd
alias j=jobs
alias git='nocorrect git'
alias gst='nocorrect git st'
alias gs='nocorrect git show'

wt() {
        while true ; do ( $@ ) ; sleep 1 ; clear ; done
}

yyyymmdd () { date +%Y%m%d ; }
yyyymmdd-hhmmss () { date +%Y%m%d-%H%M%S ; }
alias ymd=yyyymmdd
alias ymd-hms=yyyymmdd-hhmmss

function vman() { vim -c ":RMan ${*}" ; }
function vimgrep () { tmp="$@" ; vim -c "vimgrep $tmp" ; }
