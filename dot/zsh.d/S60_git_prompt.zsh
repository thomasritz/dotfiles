# zgitinit and prompt_rittsu_setup must be somewhere in your $fpath, see README for more.

setopt promptsubst

function git_prompt_info() {
  local ref branch

  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  branch=${ref#refs/heads/}

  echo -n " ‹%{$fg[blue]%}${branch}%{$reset_color%}›"
  echo
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


# screen sets title to executed command
# requires in .screenrc:
#   aclchg :window: -rwx  #?
#   aclchg :window: +x title
# http://matthew.loar.name/blog/2007/11/06/zsh__screen_for_great_justice/

function zsh_default_title_precmd {
  echo -ne "\033]83;title zsh\007"
}

precmd_functions+='zsh_default_title_precmd'


function zsh_title_preexec {
  local cmdline="$2 "
  local cmd=${${=cmdline}[1]}
  echo -ne "\033]83;title $cmd\007"
}

preexec_functions+='zsh_title_preexec'
