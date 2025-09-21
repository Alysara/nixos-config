#!/usr/bin/env bash
set -e

git add ~/.dotfiles
git commit -m "${1:-"This is an automated commit"}"
git push github main

echo "Successfully updated the github repo."
