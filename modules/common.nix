{ self, inputs, ... }: {
  flake.nixosModules.common = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.greetd
      self.nixosModules.homeManagerSetup
      #      self.nixosModules.steam
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelParams = [
      "vt.default_red=0x30,0xe7,0xa6,0xe5,0x8c,0xf4,0x81,0xb5,0x51,0xed,0xb9,0xec,0xad,0xf3,0x98,0xa5"
      "vt.default_grn=0x34,0x82,0xd1,0xc8,0xaa,0xb8,0xc8,0xbf,0x57,0xa0,0xdb,0xd7,0xc2,0x8e,0xd2,0xad"
      "vt.default_blu=0x46,0x84,0x89,0x90,0xee,0xe4,0xbe,0xe2,0x6d,0xa2,0xa2,0xae,0xf3,0xd4,0xc8,0xce"
    ];

    console = {
      enable = true;
      font = "ter-v16b";
      packages = with pkgs; [ terminus_font ];
    };

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
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

    programs.zsh.enable = true;

    users.users."dev" = {
      isNormalUser = true;
      description = "dev";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.zsh;

      packages = with pkgs; [ ];
    };

    nixpkgs.config.allowUnfree = true;

    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 3";
      };
    };

    programs.nix-index = {
      enable = true;
      enableZshIntegration = true;
    };

    environment.systemPackages = with pkgs; [
      git
      nix-output-monitor
    ];

    system.stateVersion = "26.05";
  };
}
