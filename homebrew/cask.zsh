if [[ "$OSTYPE" == "darwin"* ]] && command -V brew ; then
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
fi
