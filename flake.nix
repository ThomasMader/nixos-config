{
  description = "A very basic flake";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-23.11;
  inputs.NixOS-WSL = {
    url = "github:nix-community/NixOS-WSL";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, NixOS-WSL }: {
    nixosConfigurations = {
      five = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          { nix.registry.nixpkgs.flake = nixpkgs; }
          ./wsl-configuration.nix 
          NixOS-WSL.nixosModules.wsl
        ];
      };
      nine = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./nine-configuration.nix ];
      };
    };

  };
}
