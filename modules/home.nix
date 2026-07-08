{ self, inputs, ... }: {
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.nixosModules.homeManagerSetup = {pkgs, lib, config, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "bak";

      users.dev = { pkgs, ... }: {
        home.stateVersion = config.system.stateVersion;

        imports = [
          self.homeModules.brave
          self.homeModules.alacritty
          self.homeModules.nvf
          self.homeModules.zsh
          self.homeModules.lazygit
          self.homeModules.btop
          self.homeModules.htop
          self.homeModules.fzf
          self.homeModules.eza
          self.homeModules.bat
          self.homeModules.yazi
          self.homeModules.fastfetch
          self.homeModules.spotify-player
          self.homeModules.ripgrep
        ];

        home.packages = with pkgs; [
          fd
          discord
        ];
      };
    };
  };
}
