{ ... }:

{
  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" "intel" ];
  hardware.nvidia.open = true;
}