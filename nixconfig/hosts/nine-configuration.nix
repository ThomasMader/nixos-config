{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../non-wsl.nix
      ../desktop.nix
      ./nine-hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-464a9c12-8568-4732-806e-a4e514440dc1".device = "/dev/disk/by-uuid/464a9c12-8568-4732-806e-a4e514440dc1";
  networking.hostName = "nine";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
