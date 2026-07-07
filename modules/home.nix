{ self, inputs, ... }: {
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
        ];

        home.packages = with pkgs; [

        ];
      };
    };
  };
};
