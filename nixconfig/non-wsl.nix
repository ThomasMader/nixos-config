# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.thomad = {
    isNormalUser = true;
    uid = 1001;
    createHome = true;
    home = "/home/thomad";
    useDefaultShell = true;
    group = "users";
    extraGroups = [ 
      "wheel"
      "networkmanager" 
      "vboxsf" 
      "docker" 
    ];
  };

  environment.systemPackages =
    with pkgs; [
      kanata
  ];

  services.kanata = {
    enable = true;
    # TODO load complete config from file instead
    keyboards = {
      "default".extraDefCfg = ''
        linux-dev-names-exclude (
          ;; USB connected Glove80
          "MoErgo Glove80 Left Keyboard"

          ;; Bluetooth connected Glove80
          "Glove80 Keyboard"
        )

        windows-altgr cancel-lctl-press

        log-layer-changes no
        process-unmapped-keys yes
      '';
      "default".config =
      (builtins.readFile ../dotfiles/kanata/kanata.kbd);
    };
  };
}

