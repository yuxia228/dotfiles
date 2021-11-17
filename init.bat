@echo off

cd /d %~dp0

REM alacritty
mkdir %HOMEPATH%\AppData\Roaming\alacritty\
copy /Y .\alacritty.yml %HOMEPATH%\AppData\Roaming\alacritty\alacritty.yml


