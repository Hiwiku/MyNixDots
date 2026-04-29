{ config, pkgs, ... }:


{
  imports = [
 # ./home-manager/niri.nix

  ];

  home.username = "hiwiku";
  home.homeDirectory = "/home/hiwiku";
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "BreezeX-RosePine-Linux";
    size = 16;
    package = pkgs.rose-pine-cursor;
  };

  home.packages = with pkgs; [
    #htop
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
