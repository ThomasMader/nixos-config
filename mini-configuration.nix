{ config, lib, pkgs, ... }:

{
  boot.kernelModules = [ "kvm-intel" "wl" "msr" "coretemp" "applesmc" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  boot.initrd.kernelModules = [ 
    "nls-cp437" # /boot
    "nls-iso8859-1" # /boot
    "vfat" # /boot
  ];
  boot.kernelPackages = pkgs.linuxPackages;
  boot.loader.systemd-boot.editor = false;

  networking.hostName = "mini";

  services.xserver.displayManager.gdm.autoLogin = {
    enable = true;
    user = "thomad";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
