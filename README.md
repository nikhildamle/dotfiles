# dotfiles

## install

Run this:

```sh
git clone https://github.com/nikhildamle/dotfiles ~/dotfiles
python2 ~/dotfiles/__bootstrap/install.py
```

This will symlink or copy appropriate files in ~/dotfiles directory into home
directory. All files except *.copy are configured in ~/dotfiles directory.

## concept

Everything is split into topic specific areas. For example, all ruby related
files such as setting up rbenv, ~/.gemrc go into ruby directory.

Files or directories ending with .symlink will be symlinked to home directory.
Similarly files or directories ending with .copy will be copied to home directory.
For example, file ruby/gemrc.symlink will be symlinked to ~/.gemrc and file
git/gitconfig.copy will be copied to ~/.gitignore

## thanks
Thanks to [Zach Holman](http://zachholman.com/) and his [dotfiles](https://github.com/holman/dotfiles)
from where this topic specific idea is derived.
