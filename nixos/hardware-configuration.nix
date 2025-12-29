{
  config,
  lib,
  ...
}:

{
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    # "ahci" SATA
    "usbhid"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    # "kvm-amd" VM
    "ntsync"
  ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/385d88a3-0fd4-47f4-ae55-474ef8e049b1";
    fsType = "btrfs"; # Switch to BcacheFS in the future
    options = [
      "noatime"
      "compress=no"
      "space_cache=v2"
      "commit=120"
      "discard=async"
      "ssd"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2A3C-8D77";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
