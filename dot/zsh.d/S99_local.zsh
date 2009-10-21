alias t="ssh tux"
alias p="ssh private"


set_git_identity() {
  if [[ $PWD == */(private|other|Pictures|Volumes/DOCS)(|/*) ]]; then
    export GIT_AUTHOR_EMAIL="thomas@galaxy-ritz.de"
  else
    unset GIT_AUTHOR_EMAIL
  fi
}

typeset -ga chpwd_functions
chpwd_functions+='set_git_identity'
