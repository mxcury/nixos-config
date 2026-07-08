{ self, inputs, ... }: {
  flake.homeModules.fzf = { pkgs, ... }: {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [ "--height 40%" "--layout=reverse" "--border" ];
    };
  };
}
