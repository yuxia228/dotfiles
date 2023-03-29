local wezterm = require 'wezterm';

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)
wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local edge_background = '#0b0022'
    local background = '#1b1032'
    local foreground = '#808080'

    if tab.is_active then
      background = '#2b2042'
      foreground = '#c0c0c0'
    elseif hover then
      background = '#3b3052'
      foreground = '#909090'
    end

    local edge_foreground = background

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    local title = wezterm.truncate_right(tab.active_pane.title, max_width - 2)

    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_LEFT_ARROW },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_RIGHT_ARROW },
    }
  end
)

return {
    default_prog = {
        "wsl.exe", "~",
    },
    font = wezterm.font_with_fallback({
        "Ricty Diminished",
        "Fira Code",
        "DengXian",
    }),
    font_size = 11.0,
    adjust_window_size_when_changing_font_size = false,
    launch_menu = {
        {
            label = "cmd",
            args = {"cmd.exe"}
        },
        {
            label = "WSL",
            args = {"wsl.exe", "~"},
        },
        {
            label = "Powershell",
            args = {"powershell.exe"}
        },
        {
            label = "Cygwin(chere is required)",
            args = {"C:/cygwin64/bin/bash.exe", "/bin/xhere", "/bin/bash", "~"}
        },
    },
}

