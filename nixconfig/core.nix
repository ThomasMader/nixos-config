# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  nix.extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
  '';

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 2d";

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
    alias mojo_bash='podman run --cap-add SYS_PTRACE -it --rm -p 8888:8888 --net host -v $PWD:$PWD modular/mojo-v-20241506-0022 bash'
    alias mojo_build_container='cd ~/devel/mojo/examples/docker/ && bash build-image.sh --use-podman --mojo-version'
  '';

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  virtualisation.podman.enable = true;

  environment.systemPackages =
    with pkgs; [
      binutils vim git gh google-chrome pciutils usbutils gparted vlc efibootmgr kdiff3 curl audacious exfat ntfs3g hdparm mplayer gptfdisk glxinfo wol rdesktop wget ripgrep fzf lazygit fd signal-desktop gimp xorg.xkbcomp clang unzip nodejs xclip wezterm
      (python3.withPackages(ps: with ps; [ pip ]))
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  services = {
    logind.lidSwitch = "lock";
  };

  nix.settings.sandbox = true;
  nix.settings.cores = 0;

}

