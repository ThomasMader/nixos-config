# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.extraOptions = ''
      gc-keep-outputs = true
      gc-keep-derivations = true
  '';

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 180d";

  # Disable USB-based wakeup
  # see: https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate
  powerManagement.powerUpCommands = ''
      if cat /proc/acpi/wakeup | grep XHC1 | grep -q enabled; then
        echo XHC1 > /proc/acpi/wakeup
      fi
  '';

  networking.nameservers = [ "192.168.0.1" "8.8.8.8" "8.8.4.4" ];
  networking.networkmanager.enable = lib.mkForce true;
  networking.wireless.enable = lib.mkForce false;

  networking.firewall = {
    allowPing = true;
    # Chromecast rules to let the UDP unicast packets pass to detect the devices.
    extraCommands =
      ''
       iptables -I INPUT -p udp -m udp -s 192.168.1.7 --dport 32768:61000 -j ACCEPT 
       iptables -I INPUT -p udp -m udp -s 192.168.1.6 --dport 32768:61000 -j ACCEPT 
      '';
  };

  #fileSystems."/data" = {
  #  device = "/dev/disk/by-label/data";
  #  fsType = "exfat";
  #};

  # Select internationalisation properties.
   i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "de";
     defaultLocale = "en_US.UTF-8";
   };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  hardware = {
	pulseaudio.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    nix-repl git vimHugeX google-chrome pciutils usbutils gparted vlc efibootmgr kdiff3 curl audacious exfat ntfs3g hdparm mplayer gptfdisk dmd
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "at";
    libinput.enable = false;
    synaptics.enable = true;
    synaptics.twoFingerScroll = true;
    synaptics.horizontalScroll = true;
    synaptics.vertTwoFingerScroll = true;
    synaptics.horizTwoFingerScroll = true;

    desktopManager.gnome3.enable = true;

    displayManager.auto = {
      enable = true;
      user = "thomad";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.thomad = {
    isNormalUser = true;
    uid = 1001;
    createHome = true;
    home = "/home/thomad";
    useDefaultShell = true;
    group = "users";
    extraGroups = [ "wheel" "networkmanager" "vboxsf" ];
  };

  nix.useSandbox = true;
  nix.buildCores = 0;

}

