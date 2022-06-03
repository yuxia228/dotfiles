local wezterm = require 'wezterm';
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
    },
}
