#!/usr/bin/env bash
set -e

./fastcommit.sh $1
home-manager switch --flake ~/.dotfiles

