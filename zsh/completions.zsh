source $DOTFILES_DIR/zsh/helpers.sh

# case-insensitive tab completion for filenames (useful on Mac OS X)
if isOSX; then
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
fi

if [ -d '/usr/local/share/zsh-completions' ]; then
	fpath=(/usr/local/share/zsh-completions $fpath)
elif [ -d '/usr/share/zsh-completions' ]; then
	fpath=(/usr/share/zsh-completions $fpath)
fi

autoload -U compinit
compinit
