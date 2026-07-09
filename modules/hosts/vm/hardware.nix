{ self, inputs, ... }: {

  flake.nixosModules.vmHardware =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "ata_piix"
        "ohci_pci"
        "ehci_pci"
        "ahci"
        "sd_mod"
        "sr_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/ef7282aa-55a9-4289-b570-7627f09da865";
        fsType = "btrfs";
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-uuid/ef7282aa-55a9-4289-b570-7627f09da865";
        fsType = "btrfs";
        options = [ "subvol=home" ];
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/ef7282aa-55a9-4289-b570-7627f09da865";
        fsType = "btrfs";
        options = [ "subvol=nix" ];
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/dc0ff48e-37d2-46ed-954b-f505559c7c46"; }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      virtualisation.virtualbox.guest.enable = true;
    };

}
