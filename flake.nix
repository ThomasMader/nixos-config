{
  description = "NixOS configurations";

  inputs = {
    # Using unstable for now because of issues with nvim
    #nixpkgs.url = github:NixOS/nixpkgs/nixos-24.05;
    nixpkgs.url = github:NixOS/nixpkgs/a58bc8ad779655e790115244571758e8de055e3d;
    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL/2405.5.4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
        # Using unstable for now because of issues with nvim
        #url = "github:nix-community/home-manager/release-24.05";
        url = "github:nix-community/home-manager/master";
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
