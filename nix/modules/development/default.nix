{ pkgs, ... }:

{
  imports = [ ./neovim.nix ];

  home.packages = with pkgs; [
    gh
    zellij
    bun
    nodejs_20
    corepack
    typescript
    prettierd
  ];
}
