{ self, inputs, ... }: {
  flake.homeModules.btop = { pkgs, ... }: {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "Default";
        theme_background = false;
        vim_keys = true;
        rounded_corners = true;
        update_ms = 200;
      };
    };
  };
}
