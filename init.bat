@echo off

cd /d %~dp0

REM alacritty
mkdir %HOMEPATH%\AppData\Roaming\alacritty\
copy /Y .\alacritty.yml %HOMEPATH%\AppData\Roaming\alacritty\alacritty.yml
mkdir %HOMEPATH%\scoop\apps\wezterm\current\
copy /Y .\wezterm.lua %HOMEPATH%\scoop\apps\wezterm\current\wezterm.lua

