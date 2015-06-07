# Creates directory and cd's into it
take () {
  mkdir -p "$*"
  cd "$*"
}