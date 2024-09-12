{ inputs, ... }:

{
  imports = [
    ./apps
    ./utils
    ./terminal
    ./environment
    ./development
    ./media
    ./gaming

    inputs.ags.homeManagerModules.default
  ];

  home = {
    username = "etherbits";
    homeDirectory = "/home/etherbits";
    stateVersion = "24.05";
  };

}
