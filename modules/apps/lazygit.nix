{ self, inputs, ... }: {
  flake.homeModules.lazygit = { pkgs, ... }: {
    programs.lazygit = {
      enable = true;
      settings = {
        gui.showIcons = true;
      };
    };
  };

}
