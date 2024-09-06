{ pkgs, pkgs-unstable, ... }:

{
  imports = [ ./neovim.nix ];

  home.packages = (with pkgs; [
    gh
    bun
    nodejs_20
    corepack
    typescript
    prettierd
    eslint_d
    vscode-langservers-extracted
    nodePackages."@tailwindcss/language-server"
    nodePackages.bash-language-server
    go
    gopls
    go-jet
    air
    python3
    pyright
    libgcc
    rustup
    postgresql
    turso-cli
    sqls
    bruno
    jq
  ])
  ++
  (with pkgs-unstable;
  [
    infisical
  ]);

  programs.git = {
    enable = true;
    userName = "etherbits";
    userEmail = "nika.qvrivishvili@gmail.com";
  };
}
