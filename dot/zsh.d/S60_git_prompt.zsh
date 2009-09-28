# zgitinit and prompt_rittsu_setup must be somewhere in your $fpath, see README for more.

setopt promptsubst

function git_prompt_info() {
  local git_dir
  git_dir=$(git rev-parse --git-dir 2>/dev/null)
  if [ $? -ne 0 ] || [ -z "$git_dir" ]; then
    return
  fi

  local git_status
  git_status=$(git status 2>/dev/null)

  local git_ref_name
  git_ref_name=$(echo $git_status | grep '^# On branch ' | sed 's/^# On branch //')

  local git_is_initial_commit
  git_is_initial_commit=$(echo $git_status | grep -c '# Initial commit')

  local git_describe
  if [[ $git_is_initial_commit = 1 ]]; then
    git_describe="Initial commit"
  else
    git_describe=$(git describe --always HEAD 2>/dev/null)
    if [ $? -ne 0 ]; then
      git_describe=$(git rev-parse HEAD)
      git_describe=$git_describe[0,8]
    fi
  fi


  local git_is_dirty
  git_is_dirty=$(echo $git_status | sed 's/^#.*$//' | tail -2 | grep 'nothing to commit (working directory clean)'; echo $?)

  echo -n " on %{$fg[blue]%}${git_ref_name}%{$reset_color%}"
  echo -n " • %{$fg[blue]%}${git_describe}%{$reset_color%}"
  if [[ $git_is_dirty = 1 ]]; then
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
