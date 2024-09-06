{ inputs, ... }:

{
  imports = [
    ./apps
    ./utils
    ./terminal
    ./environment
    ./development
    ./media

    inputs.ags.homeManagerModules.default
  ];

  home = {
    username = "etherbits";
    homeDirectory = "/home/etherbits";
    stateVersion = "24.05";
  };

}
