{ inputs, ... }: {
  flake.homeModules.nvf = { pkgs, config, ... }: {
    imports = [
      inputs.nvf.homeManagerModules.default
      inputs.matugen.nixosModules.default
    ];

    programs.matugen = {
      enable = true;
      templates.nvim-base16 = {
        input_path = "${config.xdg.configHome}/nvim/lua/matugen-template.lua";
        output_path = "${config.xdg.configHome}/nvim/lua/matugen.lua";
        post_hook = "pkill -SIGUSR1 nvim";
      };
    };

    xdg.configFile."nvim/lua/matugen-template.lua".text = ''
      local M = {}
      function M.setup()
        require('base16-colorscheme').setup {
          base00 = '{{colors.surface.default.hex}}',
          base01 = '{{colors.surface_container.default.hex}}',
          base02 = '{{colors.surface_container_high.default.hex}}',
          base03 = '{{colors.outline.default.hex}}',
          base04 = '{{colors.on_surface_variant.default.hex}}',
          base05 = '{{colors.on_surface.default.hex}}',
          base06 = '{{colors.on_surface.default.hex}}',
          base07 = '{{colors.on_background.default.hex}}',
          base08 = '{{colors.error.default.hex}}',
          base09 = '{{colors.tertiary.default.hex}}',
          base0A = '{{colors.secondary.default.hex}}',
          base0B = '{{colors.primary.default.hex}}',
          base0C = '{{colors.tertiary_fixed_dim.default.hex}}',
          base0D = '{{colors.primary_fixed_dim.default.hex}}',
          base0E = '{{colors.secondary_fixed_dim.default.hex}}',
          base0F = '{{colors.error_container.default.hex}}',
        }
      end

      local signal = vim.uv.new_signal()
      signal:start('sigusr1', vim.schedule_wrap(function()
        package.loaded['matugen'] = nil
        require('matugen').setup()
      end))

      return M
    '';

    xdg.configFile."nvim/lua/matugen.lua".source =
      "${config.programs.matugen.theme.files}/.config/nvim/lua/matugen.lua";

    programs.nvf = {
      enable = true;
      settings.vim = {
        viAlias = true;
        vimAlias = true;

        theme.enable = false;

        extraPlugins = with pkgs.vimPlugins; {
          base16-nvim = {
            package = base16-nvim;
          };
        };

        luaConfigRC.matugen = ''
          vim.opt.runtimepath:append(vim.fn.expand("~/.config/nvim"))

          local status, matugen = pcall(require, "matugen")
          if status then
            matugen.setup()
          else
            vim.cmd("colorscheme retrobox") -- Safe fallback
          end
        '';

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
