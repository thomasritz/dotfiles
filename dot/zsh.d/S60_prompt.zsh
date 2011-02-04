# zgitinit and prompt_rittsu_setup must be somewhere in your $fpath, see README for more.

setopt promptsubst

function git_prompt_info() {
  local ref branch

  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  branch=${ref#refs/heads/}

  echo -n " ‹%{$fg[blue]%}${branch}%{$reset_color%}›"
  echo
}

function rvm_prompt() {
  local rvm_info
  rvm_info=$(~/.rvm/bin/rvm-prompt 2> /dev/null)
  if [ -z "$rvm_info" ]; then
    rvm_info="system ruby"
  fi
  echo " ‹%{$fg[green]%}${rvm_info}%{$reset_color%}›"
}

prompt_precmd() {
  local ex=$?
  psvar=()

  if [[ $ex -ge 128 ]]; then
    sig=$signals[$ex-127]
    psvar[1]="sig${(L)sig}"
  else
    psvar[1]="$ex"
  fi
}

PROMPT=
PROMPT+="%{$fg[cyan]%}%(2~.%~.%/)%{$reset_color%}"
PROMPT+="\$(git_prompt_info)"
PROMPT+="\$(rvm_prompt)"
PROMPT+="
"
PROMPT+="%{$fg[yellow]%}%(!.#.∴)%{$reset_color%} "


RPROMPT=
if [[ $TERM != screen* ]] || [ -z "$STY" ]; then
  RPROMPT+="%{$fg[cyan]%}%D{%Y-%m-%d} %{$fg[blue]%}%D{%T}%{$reset_color%} "
fi
RPROMPT+="%{$fg[cyan]%}%n@%m%{$reset_color%}"
RPROMPT+="%(?.. %{$fg[red]%}exited %1v%{$reset_color%})"

precmd_functions+='prompt_precmd'
