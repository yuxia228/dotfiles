@echo off

cd /d %~dp0

REM alacritty
mkdir %HOMEPATH%\AppData\Roaming\alacritty\
copy /Y .\alacritty.yml %HOMEPATH%\AppData\Roaming\alacritty\alacritty.yml
copy /Y .\alacritty.toml %HOMEPATH%\AppData\Roaming\alacritty\alacritty.toml
mkdir %HOMEPATH%\.config\wezterm
copy /Y .\wezterm.lua %HOMEPATH%\.config\wezterm\wezterm.lua

