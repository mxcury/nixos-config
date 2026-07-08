{ config, pkgs, inputs, ... }: {

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
            package = inputs.vimUtils.buildVimPlugin {
              name = "noctalia-nvim";
              src = inputs.noctalia-nvim;
            };
            
            setup = ''
              require('noctalia').setup({ 
                palette_path = vim.fn.expand("~/.config/noctalia/colors.json"),
                auto_reload = true, -- Watches for wallpaper changes and hot-reloads Neovim live!
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
          theme = "auto"; # "auto" lets lualine read the colorscheme dynamic values directly
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
