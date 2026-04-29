{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./system/base-packages.nix
      ./system/nvidia.nix
    ];

  #####
  ### BOOTLOADER
  #####
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #####
  ### NETWORK
  #####
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "socks5://192.168.0.225:10808";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #####
  ### DISKS
  #####
  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/1cea8c65-0582-40f5-bf7e-e6dc34ea6117";
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };


  #####
  ### TIMEZONE, LOCALES
  #####
  time.timeZone = "Asia/Yakutsk";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  #####
  ### X-servers
  #####
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  programs.niri.enable = true;


  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

  };



  #Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hiwiku = {
    isNormalUser = true;
    description = "hiwiku";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };


  #####
  ### BLUETOOTH
  #####
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;


  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;


  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  ];

  # xdg.portal = {
  #     enable = true;
  #     extraPortals = with pkgs; [
  #       xdg-desktop-portal-gtk
  #       xdg-desktop-portal-gnome
  #     ];
  #     config = {
  #       niri = {
  #         default = [ "gtk" ];
  #         "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
  #         "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
  #         "org.freedesktop.impl.portal.Secret" = [ "gnome" ];
  #       };
  #     };
  #   };

  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl
    curl
  ];

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  users.defaultUserShell = pkgs.fish;

  system.stateVersion = "26.05";

}
