{ self, inputs, ... }: {
  flake.homeModules.bat = { pkgs, ... }: {
    programs.bat = {
      enable = true;
      config = {
        style = "numbers,changes,header";
      };
    };
  };
}
