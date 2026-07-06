{ self, inputs, ... }: {
  flake.nixosModules.common = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.greetd
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelParams = [
      "vt.default_red=0x1e,0xf3,0xa6,0xf9,0x89,0xcb,0x89,0xcd,0x6c,0xf3,0xa6,0xf9,0x89,0xcb,0x89,0xa6"
      "vt.default_grn=0x1e,0x8e,0xe3,0xe2,0xb4,0xa5,0xd2,0xd6,0x70,0x8e,0xe3,0xe2,0xb4,0xa5,0xd2,0xad"
      "vt.default_blu=0x2e,0xa2,0xa5,0xaf,0xfa,0xe8,0xb9,0xf4,0x7e,0xa2,0xa5,0xaf,0xfa,0xe8,0xb9,0xb8"
    ];

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
