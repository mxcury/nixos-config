{ self, inputs, ... }: {
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.nixosModules.homeManagerSetup =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupCommand = "mv -v \"$@\" \"$@.bak-$(date +%Y%m%d%H%M%S)\"";

        users.dev = { pkgs, ... }: {
          home = {
            stateVersion = config.system.stateVersion;
            pointerCursor = {
              enable = true;
              gtk.enable = true;
              package = pkgs.bibata-cursors;
              name = "Bibata-Modern-Ice";
              size = 24;
            };
          };

          imports = [
            self.homeModules.brave
            self.homeModules.alacritty
            self.homeModules.vscodium
            self.homeModules.git
            self.homeModules.nvf
            self.homeModules.zsh
            self.homeModules.lazygit
            self.homeModules.btop
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
