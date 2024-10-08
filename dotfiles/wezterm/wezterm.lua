local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "tokyonight_night"
config.use_fancy_tab_bar = true

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'tokyonight_night'
  else
    return 'tokyonight_day'
  end
end

-- Disable auto colorscheme changes for now
--config.color_scheme = scheme_for_appearance(get_appearance())

-- Taken from https://github.com/folke/dot/tree/master/config/wezterm
require("tabs").setup(config)
-- TODO Next step is to try out https://github.com/mrjones2014/smart-splits.nvim and set up the keys to also work with nvim.
require("keys").setup(config)

--config.leader = { key = 'F11', mods = '' }

--[[
config.keys = {
  {
    key = '|',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
}
]]--

config.scrollback_lines = 10000

return config
