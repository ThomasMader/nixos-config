{
  description = "A very basic flake";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-23.11;

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./wsl-configuration.nix ];
      };
      nine = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./nine-configuration.nix ];
      };
    };

  };
}
