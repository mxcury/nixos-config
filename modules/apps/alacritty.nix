{ self, inputs, ... }: {
  flake.homeModules.alacritty = { pkgs, ... }: {
    programs.alacritty = {
      enable = true;
      settings = {
	  general.import = [ "~/.config/alacritty/themes/noctalia.toml" ];

        window = {
          decorations = "None";
          padding = { x = 12; y = 12; };
        };

        font = {
          size = 11.5;
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
        };
      };
    };
  };

}
