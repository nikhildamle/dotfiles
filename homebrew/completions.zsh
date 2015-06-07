if [[ "$OSTYPE" == "darwin"* ]] && command -V brew > /dev/null ; then
	fpath=(/usr/local/share/zsh/site-functions $fpath)
fi

autoload -U compinit
compinit
