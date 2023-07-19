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
    export GIT_CONFIG_SYSTEM="$HOME/Projects/zeals-co-ltd/configs/git/github_global"
    export GIT_CONFIG_GLOBAL="$HOME/Projects/zeals-co-ltd/configs/git/github_global"
    export GOPRIVATE="github.com/zeals-co-ltd"
  '';
}
