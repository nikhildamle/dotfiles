#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
  source_dir="$HOME/code/Textual"

  # pull or clone repository
  if [ -d $source_dir ]; then
    cd $source_dir
    git pull
  else
    git clone "https://github.com/Codeux/Textual.git" $source_dir
    cd $source_dir
    git submodule update --init --recursive
  fi

  # build
  xcodebuild CODE_SIGN_IDENTITY=""

  # delete old build and move new app to /Applications/
  if [[ -d "/Applications/Textual.app" ]]; then
    osascript -e 'tell application "Finder" to delete POSIX file "/Applications/Textual.app"'
  fi
  mv "Build Results/Release/Textual 5.app" "/Applications/"

  # get back to previous directory
  cd -
else
  echo 'This platform not supported. Textual is a OS X only App'
fi