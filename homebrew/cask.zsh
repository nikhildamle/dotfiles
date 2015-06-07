if [[ "$OSTYPE" == "darwin"* ]] && command -V brew > /dev/null; then
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
fi
