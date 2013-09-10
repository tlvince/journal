```metadata
title: Vim respect XDG
date: 2011-02-03
abstract: Better organisation using XDG
```

The XDG Base Directory Specification outlines a consistent standard for
applications to write runtime files. Teaching `vim` to respect it is
non-trivial, so I've simplified the set up here.

Problem
-------

You use `vim` as your primary editor *and* take active measures in keeping your
`$HOME` directory organised. `vim` is one of those "traditional" apps that
stores it's runtime files in a myriad of places. Thankfully, it's customisable
enough to solve this.

Solution
--------

As per [my set up][me], add the following to your `vimrc`:

```viml
" Environment
set directory=$XDG_CACHE_HOME/vim,~/,/tmp
set backupdir=$XDG_CACHE_HOME/vim,~/,/tmp
set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME
let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"
```

... overriding `~/.vimrc`'s location by exporting `$VIMINIT` in your shell's
start-up file (perhaps `~/.bashrc`):

```bash
# Set vimrc's location and source it on vim startup
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
```

Background
----------

### Swap files

First up, recognise those god-damn `.swp` files cluttering up your project
directories? Let's get rid of them for a start. Consulting `:help swap`
reveals the files are stored in `dir[ectory]`.

`:set dir` returns the current setup, which for me is:

```viml
directory=.,~/tmp,/var/tmp,/tmp
```

Now, lets override that by adding the following in `$MYVIMRC` (usually
`~/.vimrc`):

```viml
set directory=$XDG_CACHE_HOME/vim,~/,/tmp
```

### Backup files

Next, the `.bak` files. Similarly, add the following to your `vimrc`:

```viml
set backupdir=$XDG_CACHE_HOME/vim,~/,/tmp
```

### viminfo files

Ever do a `ls -la ~` and see a flood of strange-looking `.viminfo` files? That
file is used (among other things) to store history and search terms. Thankfully,
as `:h viminfo-file-name` mentions, we can specify a different location like so:

```viml
set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
```

### vimruntime

Next, the runtime directory, `~/.vim`. Since we likely want to use the global
resources (colours, syntax files and the like), it's a good idea to replicate
the default runtime (check with `:set runtime`). My setup looks like:

```viml
set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME
```

### vimrc

The last piece in the puzzle is to override the `~/.vimrc` location itself. You
could set an alias, such as:

```bash
alias vim='vim -u "$XDG_CONFIG_HOME/vim/vimrc"'
```

... but this will only work for the currently active terminal session and not if
`vim` is launched some other way (via `mutt` or `dmenu` for example).

A more complete solution is to set `VIMINIT` like so:

```bash
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
```

  [xdg]: http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
  [prowler]: /prowler-home-cleaner
  [me]: https://github.com/tlvince/vim-config
