These are the config files from my home dir.

Contents
--------

* `.gitignore`: Some common file patterns that `git` should never track
* `.screenrc`: Used by `screen`.
* `.vimrc`: My documented `vim` configuration.
* `.zshrc` & `.zsh.d`

Installation
-------------

    git clone git://github.com/thomasritz/dotfiles
    cd dotfiles
    ./install

This creates symlinks in the home dir, e.g. `$HOME/.vimrc` pointing to
`dotfiles/dot/vimrc`.
