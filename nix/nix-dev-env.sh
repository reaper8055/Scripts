#!/usr/bin/env bash

[ -f "$HOME/Projects/scripts/nix/shell.nix" ] && nixShellFile="$HOME/Projects/scripts/nix/shell.nix"
[ -f "$HOME/Projects/scripts/nix/envrc" ] && envrcFile="$HOME/Projects/scripts/nix/envrc"

function nixinit() {
  printf "You are in %s, do you want to proceed?\n" "$PWD"
  select option in "Yes" "No" "Cancel"; do
    printf "Choose 1, 2 or 3\n"
    case $option in
      "Yes")
        projectDirectory=$PWD
        cp "$nixShellFile" "$projectDirectory"
        cp "$envrcFile" "$projectDirectory"
        [ -f "$PWD/envrc" ] && mv envrc .envrc
        direnv allow
        lorri init
        break;;
      "No")
        exit 1;;
      "Cancel")
        exit 0;;
      * )
        printf "No valid option provided. Exiting... :(\n"
        exit 1;;
    esac
  done
}

nixinit
