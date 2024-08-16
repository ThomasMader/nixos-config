{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-24.05;
    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL/2405.5.4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
        url = "github:nix-community/home-manager/release-24.05";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, NixOS-WSL }: {
    nixosConfigurations = {
      five = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          { nix.registry.nixpkgs.flake = nixpkgs; }

          ./nixconfig/hosts/five-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.thomad = import ./nixconfig/home.nix;
          }

          NixOS-WSL.nixosModules.wsl
        ];
      };
      nine = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixconfig/hosts/nine-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.thomad = import ./nixconfig/home.nix;
          }
        ];
      };
    };

  };
}
