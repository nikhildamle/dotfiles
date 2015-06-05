#!/usr/bin/env bash

HASH="%C(yellow)%h%C(reset)"
RELATIVE_TIME="%C(green)%ar%C(reset)"
TIP="%C(red)%d%C(reset)"
AUTHOR="%C(blue)%an%C(reset)"
COMMIT_MESSAGE="%s"
git log --color --graph --decorate --pretty="tformat:$HASH - $RELATIVE_TIME $TIP - $AUTHOR - $COMMIT_MESSAGE" $* |  less -FXRS
