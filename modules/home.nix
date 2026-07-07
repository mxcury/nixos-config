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
          self.homeModules.zsh
          self.homeModules.lazygit
        ];

        home.packages = with pkgs; [

        ];
      };
    };
  };
}
