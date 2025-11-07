{ pkgs, config, ... }:

{
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
    ];
  };
  services.xserver.videoDrivers = [ "nvidia" "intel" ];
  hardware.nvidia.open = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable; 

  hardware = {
    nvidia.modesetting.enable = true;
  };
}