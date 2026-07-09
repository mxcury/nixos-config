{ self, inputs, ... }: {
  flake.homeModules.zoxide = { pkgs, ... }: {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd"
        "cd"
      ];
    };
  };
}
