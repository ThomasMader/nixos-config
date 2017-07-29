# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  #boot.kernelPackages = pkgs.linuxPackages_4_2;
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelModules = [ "msr" "coretemp" "applesmc" ];
  #boot.extraModprobeConfig = ''
#	options snd slots=snd-hda-intel
#	option snd_hda_intel enable=0,1
  #'';
  #boot.blacklistedKernelModules = [ "snd_pcsp" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Disable USB-based wakeup
  # see: https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate
  powerManagement.powerUpCommands = ''
      if cat /proc/acpi/wakeup | grep XHC1 | grep -q enabled; then
        echo XHC1 > /proc/acpi/wakeup
      fi
  '';

  networking.hostName = "mini";
  networking.nameservers = [ "192.168.0.1" "8.8.8.8" "8.8.4.4" ];
  networking.networkmanager.enable = lib.mkForce true;
  networking.wireless.enable = lib.mkForce false;

  networking.firewall = {
    allowPing = true;
  };

  # Chromecast rules to let the UDP unicast packets pass to detect the devices.
  networking.firewall.extraCommands =
    ''
     iptables -I INPUT -p udp -m udp -s 192.168.1.7 --dport 32768:61000 -j ACCEPT 
     iptables -I INPUT -p udp -m udp -s 192.168.1.6 --dport 32768:61000 -j ACCEPT 
    '';

  fileSystems."/data" = {
    device = "/dev/disk/by-label/data";
    fsType = "ntfs";
  };

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

  #environment.variables = {
    #BROWSER = "chromium-browser";
  #};

  nixpkgs.config = {

    allowUnfree = true;

    #chromium = {
      #enablePepperFlash = true;
      #enablePepperPDF = true;
      #enableWideVine = true;
    #};
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    nix-repl git vimHugeX google-chrome pciutils usbutils gparted vlc efibootmgr kdiff3 curl audacious
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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

    # Doesn't work yet in my virtual box image.
    # displayManager.gdm.enable = true;
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
    password = "thomad";
    useDefaultShell = true;
    group = "users";
    extraGroups = [ "wheel" "networkmanager" "vboxsf" ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

}

