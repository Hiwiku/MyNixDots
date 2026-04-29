{
  pkgs,
  inputs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    #Code
    zed-editor
    obsidian
    neovim
    git

    #Terminal
    fastfetch
    kitty
    btop
    fish
    tree


    #Gaming
    beammp-launcher

    xwayland-satellite

    #Communicate
    telegram-desktop
    vesktop

    pwvucontrol
    swww
    fuzzel

    qbittorrent

    #Internet


    #Flakes
    inputs.zen-browser.packages."${pkgs.system}".default
  ];

  programs.amnezia-vpn.enable = true;

  programs.fish.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };



}
