{ pkgs, ... }:

{
  imports = [ ./neovim.nix ];

  home.packages = with pkgs; [
    gh
    zellij
  ];
}
