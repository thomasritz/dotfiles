# zgitinit and prompt_rittsu_setup must be somewhere in your $fpath, see README for more.

setopt promptsubst

function git_prompt_info() {
  local git_dir
  git_dir=$(git rev-parse --git-dir 2>/dev/null)
  if [ $? -ne 0 ] || [ -z "$git_dir" ]; then
    return
  fi

  local ref_name
  ref_name=$(git symbolic-ref -q HEAD)
  if [ $? -eq 0 ]; then
    if [[ $ref_name == refs/(heads|tags)/* ]]; then
      ref_name=${ref_name#refs/(heads|tags)/}
    fi
  else
    ref_name=$(git name-rev --name-only --no-undefined --always HEAD)
    if [[ $ref_name == remotes/* ]]; then
      ref_name=${ref_name#remotes/}
    fi
  fi

  local git_describe
  git_describe=$(git describe --always HEAD 2>/dev/null)
  if [ $? -ne 0 ]; then
    git_describe=$(git rev-parse HEAD)
    git_describe=$git_describe[0,8]
  fi

  echo -n " on %{$fg[blue]%}${ref_name}%{$reset_color%}"
  echo -n " • %{$fg[blue]%}${git_describe}%{$reset_color%}"

  if [[ $(git status | tail -n1) != "nothing to commit (working directory clean)" ]]; then
    echo -n " %{$fg[yellow]%}✗%{$reset_color%}"
  fi
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
