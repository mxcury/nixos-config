{ inputs, ... }: {
  flake.homeModules.nvf = { pkgs, ... }: {
    imports = [
      inputs.nvf.homeManagerModules.default
    ];

    programs.nvf = {
      enable = true;
      settings.vim = {
        viAlias = true; 
        vimAlias = true;
      };
    };
  };
}
