{ self, inputs, ... }: {

  flake.nixosModules.vmConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.vmHardware
      self.nixosModules.common
    ];
  
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;
    boot.loader.grub.fsIdentifier = "provided";

    networking.hostName = "vm";

    programs.nh.flake = "/home/dev/dotfiles";
    environment.sessionVariables = {
      FLAKE = "/home/dev/dotfiles";
    };

    time.timeZone = "Europe/London";

    i18n.defaultLocale = "en_GB.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };
}
