{ inputs, ... }: {
  flake.homeModules.nvf = { pkgs, ... }: {
    imports = [
      inputs.nvf.homeManagerModules.default
      inputs.matugen.homeManagerModules.default
    ];

    programs.matugen = {
      enable = true;
      templates.nvim-base16 = {
        
      };
    };

    programs.nvf = {
      enable = true;
      settings.vim = {
        viAlias = true; 
        vimAlias = true;
        theme.enable = false;
      };
    };
  };
}
