{ inputs, ... }:
{

  imports = [
    ../../modules/terminal
    ../../modules/desktop
    ../../modules/development
    ../../modules/apps
    ../../modules/media
    ../../modules/utils

    inputs.ags.homeManagerModules.default
  ];

  home = {
    username = "etherbits";
    homeDirectory = "/home/etherbits";
    stateVersion = "24.05";
  };

  programs.git = {
    userName = "etherbits";
    userEmail = "nika.qvrivishvili@gmail.com";
  };


}

