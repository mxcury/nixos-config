{ self, inputs, ... }: {

  flake.nixosModules.nixosConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.nixosHardware
      self.nixosModules.common
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos";

    programs.nh.flake = "/home/dev/nixos-config";
    environment.sessionVariables = {
      FLAKE = "/home/dev/nixos-config";
    };

    environment.etc."systemd/system-sleep/lock-noctalia" = {
      mode = "0755";
      source = pkgs.replaceVars ./lock-noctalia.sh {
        noctalia_bin = "${
          self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia-wrapped
        }/bin/noctalia-shell";
        id_bin = "${pkgs.coreutils}/bin/id";
        timeout_bin = "${pkgs.coreutils}/bin/timeout";
      };
    };

    services.xserver.xkb = {
      layout = "gb";
      variant = "";
    };
    console.keyMap = "uk";
    services.upower.enable = true;
    hardware.bluetooth.enable = true;

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
