{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  buildInputs = [
    go
    zsh
    gotools
    gopls
    go-outline
    gocode
    gopkgs
    gocode-gomod
    godef
    golint
    fnm
    nodejs
    yarn
    rnix-lsp
    fd
    golangci-lint
  ];
  shellHook = ''
    export GIT_CONFIG_NOSYSTEM=true
    export GIT_CONFIG_SYSTEM="$HOME/Projects/git/config/github_global"
    export GIT_CONFIG_GLOBAL="$HOME/Projects/git/config/github_global"
  '';
}
