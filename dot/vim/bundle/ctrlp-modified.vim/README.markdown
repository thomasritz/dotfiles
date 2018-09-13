# ctrlp-modified.vim

Easily open locally modified files in your git-versioned projects.

The idea is that you're likely to be editing the same files again, or maybe
you just want to catch up on the progress you've made after coming back from a break.

* `:CtrlPModified` shows all files which have been modified since your last commit.
* `:CtrlPBranch` shows all files modified on your current branch.
* `:CtrlPBranchModified` combines the two.

## Installation

Add `ctrlp-modified` after `ctrlp` in your [Vundle](https://github.com/gmarik/vundle) config:

``` vim
Bundle 'kien/ctrlp.vim'
Bundle 'jasoncodes/ctrlp-modified.vim'
```

Then set yourself up some mappings:

``` vim
map <Leader>m :CtrlPModified<CR>
map <Leader>b :CtrlPBranch<CR>
map <Leader>B :CtrlPBranchModified<CR>
```

## Configuration

The `g:ctrlp#modified#excludes` variable may optionally be set to a string with a regex for file
paths to exclude from the search, such as `"^vendor"`.

## License

MIT License.
