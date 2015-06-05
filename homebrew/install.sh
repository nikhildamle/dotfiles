#!/usr/bin/env zsh

if command -V brew ; then
  echo "Homebrew Already Installed. Updating Homebrew."
  brew update
else
  echo "Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
