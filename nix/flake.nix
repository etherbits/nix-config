{
  description = "Etherbits NixOs configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

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
      nixosConfigurations = {
        laptop = mkSystem ./hosts/laptop/configuration.nix;
      };

      homeConfigurations = {
        "etherbits@laptop" = mkHome "x86_64-linux" ./hosts/laptop/home.nix;
      };

      # homeManagerModules.default = ./homeManagerModules;
      # nixosModules.default = ./nixosModules;
    };
}
