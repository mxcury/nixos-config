{ inputs, self, ... }: {
  flake.homeModules.nvf =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      imports = [
        inputs.nvf.homeManagerModules.default
      ];

      xdg.configFile."nvim/lua/matugen-template.lua".source = "./matugen-template.lua";
      xdg.configFile."noctalia/user-templates.toml".source = "./user-templates.toml";

      programs.nvf = {
        enable = true;
        settings.vim = {
          viAlias = true;
          vimAlias = true;

          extraPackages = [ pkgs.git ];

          options = {
            tabstop = 2;
            shiftwidth = 2;
            expandtab = true;
          };

          theme.enable = false;

          extraPlugins = with pkgs.vimPlugins; {
            base16-nvim = {
              package = base16-nvim;
            };
          };

          additionalRuntimePaths = [ "${config.home.homeDirectory}/.config/nvim" ];

          luaConfigRC = {
            matugen = ''
              pcall(function() require('matugen').setup() end)
            '';

            treesitter-autostart = ''
              vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                  pcall(vim.treesitter.start)
                end,
              })
            '';
          };

          # --- The VS Code Layout & Visuals ---
          statusline.lualine.enable = true;
          tabline.nvimBufferline.enable = true;
          filetree.neo-tree.enable = true;

          visuals = {
            nvim-web-devicons.enable = true;
            nvim-cursorline.enable = true;
          };

          # --- IDE Features ---
          telescope.enable = true;
          treesitter = {
            enable = true;
            autotagHtml = true;
            grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
              nix
              lua
              toml
              json
            ];
          };

          autocomplete.nvim-cmp.enable = true;
          autopairs.nvim-autopairs.enable = true;

          lsp = {
            enable = true;
            formatOnSave = true;
            lightbulb.enable = true;
          };

          languages = {
            nix.enable = true;
            typescript.enable = true;
            html.enable = true;
            css.enable = true;
          };

          git = {
            enable = true;
            gitsigns.enable = true;
          };
        };
      };
    };
}
