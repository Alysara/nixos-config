#!/usr/bin/env bash
set -e

fastcommit $1
home-manager switch --flake ~/.dotfiles

