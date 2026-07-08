{ config, pkgs, inputs, ... }:

let
  noctalia-plugin = pkgs.vimUtils.buildVimPlugin {
    name = "noctalia-nvim";
    src = inputs.noctalia-nvim;
  };
in
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    enableManpages = true;

    settings = {
      vim = {
        theme.enable = false;

        extraPlugins = {
          noctalia = {
            package = noctalia-plugin;
            
            setup = ''
              require('noctalia').setup({ 
                palette_path = vim.fn.expand("~/.config/noctalia/colors.json"),
                auto_reload = true, 
                transparent = false,
              })
              vim.cmd.colorscheme("noctalia")
            '';
          };
        };

        options = {
          number = true;
          relativenumber = true;
        };

        statusline.lualine = {
          enable = true;
          theme = "auto";
        };

        telescope.enable = true;

        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
        };

        lsp.enable = true;
      };
    };
  };
}
