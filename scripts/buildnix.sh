#!/usr/bin/env bash
set -e

fastcommit "$1"
sudo nixos-rebuild switch --flake ~/.dotfiles
