if [[ "$OSTYPE" == "darwin"* ]] && command -V brew > /dev/null ; then
  export PATH="/usr/local/bin:$PATH"
fi
