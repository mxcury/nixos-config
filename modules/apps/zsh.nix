{ self, inputs, ... }: {
  flake.homeModules.zsh = { pkgs, ... }: {
  programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
      shellAliases = {
        lg = "lazygit";
      };
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        aws.disabled = true; # Removes clutter from default indicators
        gcloud.disabled = true;
      };
    };
  };

}
