{ self, inputs, ... }: {
  flake.homeModules.ripgrep = { pkgs, ... }: {
    home.packages = [ pkgs.ripgrep ];

    home.sessionVariables = {
      RIPGREP_CONFIG_PATH = "$HOME/.config/ripgrep/config";
    };

    home.file.".config/ripgrep/config".text = ''
      --smart-case
      --hidden
      --glob=!.git/*
    '';
  };
}
