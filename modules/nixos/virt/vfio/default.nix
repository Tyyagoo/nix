{ options, config, lib, pkgs, ... }:
with lib;
with lib.nixty;
let cfg = config.virt.vfio;
in {
  options.virt.vfio = with types; {
    enable = mkBoolOpt false "Enable GPU passthrough.";
    devices = mkOption {
      type = listOf (strMatching "[0-9a-f]{4}:[0-9a-f]{4}");
      default = [ ];
      example = [ "1002:15d8" ];
      description = "PCI IDs of devices to bind to vfio-pci";
    };
  };

  config = mkIf cfg.enable {
    boot = {
      initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
        "vfio_virqfd"

        "amdgpu"
      ];
    };

    boot.kernelParams = [
      "amd_iommu=on"
    ] ++ optional (length cfg.devices > 0) ("vfio-pci.ids=" + concatStringsSep "," cfg.devices);
  };
}
