if [[ "$OSTYPE" == "darwin"* ]] && command -V brew ; then
	fpath=(/usr/local/share/zsh/site-functions $fpath)
fi

autoload -U compinit
compinit
