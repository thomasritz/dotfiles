#! /bin/zsh

# see S10_zshopts for vi/emacs binding

# type the beginning of a command... and press the <up> key!
bindkey "^[[A"   up-line-or-search
bindkey "^[[B" down-line-or-search

bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line

bindkey "^K" kill-line
bindkey "^L" clear-screen
bindkey "^R" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward
bindkey "^W" backward-kill-word

bindkey "^N" down-history
bindkey "^P" up-history

bindkey "^D" delete-char
bindkey '\e[3~' delete-char
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\eOH' beginning-of-line
bindkey '\eOF' end-of-line


# shortcut
bindkey -s "^O" "ls\n"
