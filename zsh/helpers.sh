# Limit use of these functions to only files in zsh directory

function isOSX() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    return 0
  else
    return 1
  fi
}

function isLinux() {
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    return 0
  else
    return 1
  fi
}

function isHomeBrewInstalled() {
  if command -V brew &> /dev/null; then
    return 0
  else
    return 1
  fi
}
