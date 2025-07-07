{
  description = "Gengar flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.gengar = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configuration.nix 
          ./hardware-configuration.nix 
        ];
      };
    };
}
