# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./core.nix
    ];


  services.gnome.tracker-miners.enable = false;
  
  services.xserver = {
    enable = true;

    extraLayouts.de-thomad = {
      description = "DE thomad";
      languages = [ "de" ];
      symbolsFile = ./symbols/de-thomad;
    };

    layout = "de-thomad";

    desktopManager.gnome.enable = true;

    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = false;
  };

  # Load custom keyboard layout on boot/resume
  services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp de-thomad $DISPLAY";

  # Configure the console keymap from the xserver keyboard settings
  console.useXkbConfig = true;
}

