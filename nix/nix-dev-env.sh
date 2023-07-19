#!/usr/bin/env bash

nixShellFile="$HOME/Projects/nix/shell.nix"
envrcFile="$HOME/Projects/nix/envrc"

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
