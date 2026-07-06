{ self, inputs, ... }: {

  flake.nixosModules.machineConfiguration = { pkgs, lib, ... }: {
    # import any other modules from here
    imports = [
      self.nixosModules.machineHardware
      self.nixosModules.niri
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
    # Bootloader.
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;
    boot.loader.grub.fsIdentifier = "provided";

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "vm";
    networking.networkmanager.enable = true;

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

    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    services.printing.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    users.users."dev" = {
      isNormalUser = true;
      description = "dev";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [ ];
    };

    programs.brave.enable = true;

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      git
    ];

    system.stateVersion = "26.05";
  };

}
