{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./non-wsl.nix
      ./desktop.nix
      ./nine-hardware-configuration.nix
    ];

  networking.hostName = "nine";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
