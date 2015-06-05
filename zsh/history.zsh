export HISTSIZE=2000 
export HISTFILE="$HOME/.history"

# History wont be saved without next line.
export SAVEHIST=$HISTSIZE

# Ignore duplicates.
setopt hist_ignore_all_dups

# Ignore from history if command is preceeded with space.
setopt hist_ignore_space
