{
  description = "Etherbits NixOs configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";
  };
  outputs = { ... } @ inputs:
    let
      make = import ./helpers/make.nix { inherit inputs; };
    in
    with make; {
      inputs.home-manager.users.etherbits.nixpkgs.config.allowUnfree = true;

      nixosConfigurations = {
        desktop = mkSystem "x86_64-linux" ./hosts/desktop/configuration.nix;
        laptop = mkSystem "x86_64-linux" ./hosts/laptop/configuration.nix;
      };

      homeConfigurations = {
        "etherbits@desktop" = mkHome "x86_64-linux" ./hosts/desktop/home.nix;
        "etherbits@laptop" = mkHome "x86_64-linux" ./hosts/laptop/home.nix;
      };

      # homeManagerModules.default = ./homeManagerModules;
      # nixosModules.default = ./nixosModules;
    };
}
