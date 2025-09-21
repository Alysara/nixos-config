#!/usr/bin/env bash
set -e

./fastcommit.sh $1
sudo nixos-rebuild switch --flake ~/.dotfiles
