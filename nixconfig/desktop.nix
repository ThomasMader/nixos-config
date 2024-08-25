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

  environment.systemPackages =
    with pkgs; [
      google-chrome gparted mplayer vlc kdiff3 signal-desktop gimp wezterm
  ];

  services = {
    displayManager.autoLogin.user = "thomad";

    xserver = {
      enable = true;

      xkb.layout = "de";

      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = false;
    };
  };  

  # Workaround for getting Gnome autologin work.
  # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Configure the console keymap from the xserver keyboard settings
  console.useXkbConfig = true;
}

