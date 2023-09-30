# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./core.nix
    ];

  services.xserver = {
    enable = true;
    layout = "at";

    desktopManager.gnome.enable = true;

    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = false;
  };
}

