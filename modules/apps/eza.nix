{ self, inputs, ... }: {
  flake.homeModules.eza = { pkgs, ... }: {
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
      extraOptions = [ "--group-directories-first" "--header" "--total-size"];
    };
  };
}
