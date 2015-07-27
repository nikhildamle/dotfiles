is_osx() {
  [ "$(uname)" == "Darwin" ] || return 1
}

is_linux() {
  [ "$(expr substr $(uname -s) 1 5)" == "Linux" ] || return 1
}
