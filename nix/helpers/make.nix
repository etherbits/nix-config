{ inputs }:
let
  # make = (import ./default.nix) { inherit inputs; };
  outputs = inputs.self.outputs;
in
{
  mkSystem = config:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs;
      };
      modules = [
        config
        # outputs.nixosModules.default
      ];
    };

  mkHome = sys: config:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs { system = sys; config = { allowUnfree = true; }; };
      extraSpecialArgs = {
        inherit inputs outputs;
      };
      modules = [
        config
        # outputs.homeManagerModules.default
      ];
    };
}
