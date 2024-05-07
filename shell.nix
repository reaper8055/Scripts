{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  buildInputs = [
    # shell
    zsh
    # web
    fnm
    nodejs
    yarn
    # unix-tools
    fd
    ripgrep
  ];
  shellHook = ''
    export GIT_CONFIG_NOSYSTEM=true
    export GIT_CONFIG_SYSTEM="/home/grim_reaper/Projects/configs/github/github_global"
    export GIT_CONFIG_GLOBAL="/home/grim_reaper/Projects/configs/github/github_global"
  '';
}
