{ pkgs, ... }:

{
  imports = [ ./shell.nix ./terminal.nix ];

  home.packages = with pkgs; [
    zellij
  ];
}
