# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
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

  networking.networkmanager.enable = lib.mkForce true;
  networking.wireless.enable = lib.mkForce false;

  networking.firewall = {
    allowPing = true;
    # Chromecast rules to let the UDP unicast packets pass to detect the devices.
    extraCommands =
      ''
       iptables -I INPUT -p udp -m udp -s 192.168.0.0/16 --match multiport --dports 1900,5353 -j ACCEPT 
      '';
  };

  #fileSystems."/data" = {
  #  device = "/dev/disk/by-label/data";
  #  fsType = "exfat";
  #};

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console.font = "Lat2-Terminus16";
  console.keyMap = "de";

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  programs.bash.enableCompletion = true;
  programs.bash.interactiveShellInit = ''
    export FZF_DEFAULT_COMMAND='rg --files'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    if command -v fzf-share >/dev/null; then
      source "$(fzf-share)/key-bindings.bash"
    fi
    bind -x '"\C-k": vim $(fzf);'
  '';

  hardware = {
    pulseaudio.enable = true;
    opengl.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.interactiveShellInit = ''
    alias tmadrid_rdesktop='rdesktop -z -P -x l -g 1920x1080 -k de tmadrid'
  '';

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

 # TODO This vim setup doesn't work anymore as of NixOS 23.05, need to find another solution.
 # environment.systemPackages = let
    # See https://beyermatthias.de/blog/2015/11/25/how-to-setup-neovim-on-nixos/ for an explanation
    #vimPackages = import ./vim/vimPackages.nix pkgs;
  #in
    #vimPackages ++ (
  #  (with pkgs; [
  #    binutils git gh google-chrome pciutils usbutils gparted vlc efibootmgr kdiff3 curl audacious exfat ntfs3g hdparm mplayer gptfdisk glxinfo wol rdesktop wget ripgrep fzf signal-desktop gimp
  #]);

  environment.systemPackages =
    with pkgs; [
      binutils vim git gh google-chrome chromium pciutils usbutils gparted vlc efibootmgr kdiff3 curl audacious exfat ntfs3g hdparm mplayer gptfdisk glxinfo wol rdesktop wget ripgrep fzf signal-desktop gimp tmux neovim neovide
  ];

  programs.chromium.extensions =
  [
    "egpjdkipkomnmjhjmdamaniclmdlobbo" # firenvim
  ];

  services = {
    logind.lidSwitch = "lock";
  };

  nix.settings.sandbox = true;
  nix.settings.cores = 0;

}
