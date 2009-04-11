These are the config files from my home dir.

Contents
--------

* `.gitignore`: Some common file patterns that `git` should never track
* `.screenrc`: Used by `screen`.
* `.vimrc`: My documented `vim` configuration.
* `.zshrc` & `.zsh.d`: I use `zsh` as my shell. The config is split along multiple files. For the git aware shell prompt I included J. Corbin´s excellent `zsh-git` as git submodule which contains my own prompt theme `rittsu`.

Installation
-------------

    git clone git://github.com/thomasritz/dotfiles
    cd dotfiles
    git submodule update --init
    ./install

This creates symlinks in the home dir, e.g. `$HOME/.vimrc` pointing to
`dotfiles/dot/vimrc`.
