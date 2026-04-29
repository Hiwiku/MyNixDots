{
  config,
  pkgs,
  inputs,
  ...
}:
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = (
        with pkgs;
        [
          libva
          libva-vdpau-driver
          libvdpau-va-gl
          nvidia-vaapi-driver
          vulkan-loader
          vulkan-tools
        ]
      );
      extraPackages32 = (
        with pkgs.pkgsi686Linux;
        [
          libva-vdpau-driver
          libvdpau-va-gl
          nvidia-vaapi-driver
          vulkan-loader
        ]
      );
    };
    nvidia = {
      open = true;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement.enable = true;
      forceFullCompositionPipeline = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
  services.xserver.videoDrivers = [
    "nvidia"
  ];
}
