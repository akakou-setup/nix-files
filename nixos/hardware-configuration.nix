{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "xhci_pci" "sd_mod" "sr_mod" "sdhci_pci" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/28599aec-04fc-4b06-a655-cdc311e3eefc";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5d6516cc-b2e3-432a-b27f-9e929899a7e0";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/fb7716ba-d336-41dd-87a9-0c6c8bb6af4d"; }
    ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
