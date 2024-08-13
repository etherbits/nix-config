{ inputs }:
let
  outputs = inputs.self.outputs;
in
{
  mkSystem = system: config:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs outputs;
        pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      };
      modules = [
        config
      ];
    };

  mkHome = system: config:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs { inherit system; config = { allowUnfree = true; }; };
      extraSpecialArgs = {
        inherit inputs outputs;
        pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      };
      modules = [
        config
      ];
    };
}
