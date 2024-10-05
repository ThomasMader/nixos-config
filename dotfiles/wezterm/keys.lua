local wezterm = require("wezterm")

local act = wezterm.action
local M = {}

M.mod = "SHIFT|CTRL"

M.smart_split = wezterm.action_callback(function(window, pane)
  local dim = pane:get_dimensions()
  if dim.pixel_height > dim.pixel_width then
    window:perform_action(act.SplitVertical({ domain = "CurrentPaneDomain" }), pane)
  else
    window:perform_action(act.SplitHorizontal({ domain = "CurrentPaneDomain" }), pane)
  end
end)

---@param config Config
function M.setup(config)
  config.disable_default_key_bindings = true

  config.key_tables = {
    copy_mode = {
      -- default copy_mode mappings
      { key = 'Tab', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      { key = 'Tab', mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'Enter', mods = 'NONE', action = act.CopyMode 'MoveToStartOfNextLine' },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'Space', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =
 'Cell' } },
      { key = '$', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = '$', mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = ',', mods = 'NONE', action = act.CopyMode 'JumpReverse' },
      { key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
      { key = ';', mods = 'NONE', action = act.CopyMode 'JumpAgain' },
      { key = 'F', mods = 'NONE', action = act.CopyMode{ JumpBackward = { prev_char = false } } },
      { key = 'F', mods = 'SHIFT', action = act.CopyMode{ JumpBackward = { prev_char = false } } },
      { key = 'G', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'G', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'H', mods = 'NONE', action = act.CopyMode 'MoveToViewportTop' },
      { key = 'H', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
      { key = 'L', mods = 'NONE', action = act.CopyMode 'MoveToViewportBottom' },
      { key = 'L', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom'
},
      { key = 'M', mods = 'NONE', action = act.CopyMode 'MoveToViewportMiddle' },
      { key = 'M', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle'
},
      { key = 'O', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { key = 'O', mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { key = 'T', mods = 'NONE', action = act.CopyMode{ JumpBackward = { prev_char = true } } },
      { key = 'T', mods = 'SHIFT', action = act.CopyMode{ JumpBackward = { prev_char = true } } },
      { key = 'V', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Line' } },
      { key = 'V', mods = 'SHIFT', action = act.CopyMode{ SetSelectionMode =  'Line' } },
      { key = '^', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = '^', mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
      { key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },
      { key = 'd', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (0.5) } },
      { key = 'e', mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd' },
      { key = 'f', mods = 'NONE', action = act.CopyMode{ JumpForward = { prev_char = false } } },
      { key = 'f', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
      { key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
      { key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop' },
      { key = 'g', mods = 'CTRL', action = act.CopyMode 'Close' },
      { key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
      { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      { key = 'm', mods = 'ALT', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = 'o', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEnd' },
      { key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 't', mods = 'NONE', action = act.CopyMode{ JumpForward = { prev_char = true } } },
      { key = 'u', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (-0.5) } },
      { key = 'v', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
      { key = 'v', mods = 'CTRL', action = act.CopyMode{ SetSelectionMode =  'Block' } },
      { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      { key = 'y', mods = 'NONE', action = act.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { CopyMode =  'Close' } } },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
      { key = 'End', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = 'Home', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
      { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'LeftArrow', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      { key = 'RightArrow', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },

      -- custom vim like copy_mode mappings
      { key="Escape", mods='NONE', action=act.Multiple{act.CopyMode'Close',act.CopyMode'ClearPattern'}},
      { key = 'y', mods = 'NONE',
        action = act.Multiple {
          { CopyTo =  'ClipboardAndPrimarySelection' },
          act.CopyMode 'ClearPattern',
          { CopyMode =  'Close' }
        }
      },
      {key="u", mods="CTRL",  action=act.CopyMode("ClearSelectionMode")},
      -- Enter search mode to edit the pattern.
      -- When the search pattern is an empty string the existing pattern is preserved
      {key="/", mods="SHIFT", action=wezterm.action{Search={CaseSensitiveString=""}}},
      -- navigate any search mode results
      {key="n", mods="NONE", action=wezterm.action{CopyMode="NextMatch"}},
      {key="N", mods="SHIFT", action=wezterm.action{CopyMode="PriorMatch"}},
    },

    search_mode = {
      -- default search_mode mappings
      { key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
      { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
      { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
      { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },

      -- custom vim like search_mode mappings
      {key="Escape",mods='NONE',action=act.Multiple{act.CopyMode'Close',act.CopyMode'ClearPattern'}},
      -- Go back to copy mode when pressing enter, so that we can use unmodified keys like "n"
      -- to navigate search results without conflicting with typing into the search area.
      {key="Enter", mods="NONE", action="ActivateCopyMode"},
    },
  }

  config.keys = {
    -- Scrollback
    { mods = M.mod, key = "k", action = act.ScrollByPage(-0.5) },
    { mods = M.mod, key = "j", action = act.ScrollByPage(0.5) },
    -- New Tab
    { mods = M.mod, key = "t", action = act.SpawnTab("CurrentPaneDomain") },
    -- Splits
    { mods = M.mod, key = "Enter", action = M.smart_split },
    { mods = M.mod, key = "RightArrow", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { mods = M.mod, key = "DownArrow", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { mods = M.mod, key = 'w', action = wezterm.action.CloseCurrentPane { confirm = true }, },
    -- Move Tabs
    { mods = "SHIFT|CTRL|ALT", key = "RightArrow", action = act.MoveTabRelative(1) },
    { mods = "SHIFT|CTRL|ALT", key = "LeftArrow", action = act.MoveTabRelative(-1) },
    -- Acivate Tabs
    { mods = M.mod, key = "l", action = act({ ActivateTabRelative = 1 }) },
    { mods = M.mod, key = "h", action = act({ ActivateTabRelative = -1 }) },
    { mods = M.mod, key = "R", action = wezterm.action.RotatePanes("Clockwise") },
    -- show the pane selection mode, but have it swap the active and selected panes
    { mods = M.mod, key = "S", action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }) },
    -- Clipboard
    { mods = M.mod, key = "C", action = act.CopyTo("Clipboard") },
    { mods = M.mod, key = "Space", action = act.QuickSelect },
    { mods = M.mod, key = "X", action = act.ActivateCopyMode },
    { mods = M.mod, key = "f", action = act.Search("CurrentSelectionOrEmptyString") },
    { mods = M.mod, key = "V", action = act.PasteFrom("Clipboard") },
    { mods = M.mod, key = "M", action = act.TogglePaneZoomState },
    { mods = M.mod, key = "p", action = act.ActivateCommandPalette },
    { mods = M.mod, key = "d", action = act.ShowDebugOverlay },
    M.split_nav("resize", "CTRL", "LeftArrow", "Left"),
    M.split_nav("resize", "CTRL", "RightArrow", "Right"),
    M.split_nav("resize", "CTRL", "UpArrow", "Up"),
    M.split_nav("resize", "CTRL", "DownArrow", "Down"),
    M.split_nav("move", "CTRL", "h", "Left"),
    M.split_nav("move", "CTRL", "j", "Down"),
    M.split_nav("move", "CTRL", "k", "Up"),
    M.split_nav("move", "CTRL", "l", "Right"),
    { mods = "NONE", key = "F11", action = wezterm.action.ToggleFullScreen },
  }
end

---@param resize_or_move "resize" | "move"
---@param mods string
---@param key string
---@param dir "Right" | "Left" | "Up" | "Down"
function M.split_nav(resize_or_move, mods, key, dir)
  local event = "SplitNav_" .. resize_or_move .. "_" .. dir
  wezterm.on(event, function(win, pane)
    if M.is_nvim(pane) then
      -- pass the keys through to vim/nvim
      win:perform_action({ SendKey = { key = key, mods = mods } }, pane)
    else
      if resize_or_move == "resize" then
        win:perform_action({ AdjustPaneSize = { dir, 3 } }, pane)
      else
        local panes = pane:tab():panes_with_info()
        local is_zoomed = false
        for _, p in ipairs(panes) do
          if p.is_zoomed then
            is_zoomed = true
          end
        end
        wezterm.log_info("is_zoomed: " .. tostring(is_zoomed))
        if is_zoomed then
          dir = dir == "Up" or dir == "Right" and "Next" or "Prev"
          wezterm.log_info("dir: " .. dir)
        end
        win:perform_action({ ActivatePaneDirection = dir }, pane)
        win:perform_action({ SetPaneZoomState = is_zoomed }, pane)
      end
    end
  end)
  return {
    key = key,
    mods = mods,
    action = wezterm.action.EmitEvent(event),
  }
end

function M.is_nvim(pane)
  return pane:get_user_vars().IS_NVIM == "true" or pane:get_foreground_process_name():find("n?vim")
end

return M
