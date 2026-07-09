local M = {}

function M.setup()
  require('base16-colorscheme').setup {
    -- Background tones
    base00 = '{{colors.surface.default.hex}}',
    base01 = '{{colors.surface_container.default.hex}}',
    base02 = '{{colors.surface_container_high.default.hex}}',
    base03 = '{{colors.outline.default.hex}}',
    -- Foreground tones
    base04 = '{{colors.on_surface_variant.default.hex}}',
    base05 = '{{colors.on_surface.default.hex}}',
    base06 = '{{colors.on_surface.default.hex}}',
    base07 = '{{colors.on_background.default.hex}}',
    -- Accent colors
    base08 = '{{colors.error.default.hex | saturate 20}}',
    base09 = '{{colors.tertiary.default.hex | saturate 20 | set_hue 30}}',
    base0A = '{{colors.secondary.default.hex | saturate 25}}',
    base0B = '{{colors.primary.default.hex | saturate 15}}',
    base0C = '{{colors.tertiary_fixed_dim.default.hex | saturate 25 | set_hue 200}}',
    base0D = '{{colors.primary_fixed_dim.default.hex | saturate 15}}',
    base0E = '{{colors.secondary_fixed_dim.default.hex | saturate 25 | set_hue 280}}',
    base0F = '{{colors.error_container.default.hex | saturate 10}}',
  }
end

-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
