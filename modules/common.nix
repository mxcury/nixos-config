{ self, inputs, ... }: {
  flake.nixosModules.common = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.niri
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.networkmanager.enable = true;

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

    programs.firefox.enable = true;

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      git
    ];

    system.stateVersion = "26.05";
  };
}
