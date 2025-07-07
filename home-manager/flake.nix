{
  description = "Home Manager configuration of alex";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixos-unstable, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstablePkgs = nixos-unstable.legacyPackages.${system};
    in {
      homeConfigurations."alex" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;  
        extraSpecialArgs = {
          unstablePkgs = import nixos-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };

        modules = [
          ./home.nix
        ];
      };
    };
}
