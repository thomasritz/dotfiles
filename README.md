These are the config files from my home dir.

Contents
--------

* `.screenrc`: Used by `screen`.
* `.vimrc`: My documented `vim` configuration.
* `.tmux.conf`, `.ackrc`, and other shared home dots under `dot/`.

Installation
-------------

    git clone git://github.com/thomasritz/dotfiles
    cd dotfiles
    ./install

This creates symlinks in the home dir, e.g. `$HOME/.vimrc` pointing to
`dotfiles/dot/vimrc`.
