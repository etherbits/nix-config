{
  description = "My system configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 

    wezterm = {
      url = "github:wez/wezterm?dir=nix";
    };
  };
  outputs = { nixpkgs, home-manager, wezterm, ...} @ inputs:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ];
	
      };

      homeConfigurations.etherbits = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; config = { allowUnfree = true; }; };
        modules = [ ./home.nix ];
	extraSpecialArgs = {
		inherit inputs;
	};
      };
    };
}
