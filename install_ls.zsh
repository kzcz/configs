#!/usr/bin/env zsh
hascmd() { (( $+commands[$1] )) }
hascmd pacman || echo "This script at the moment only supports arch linux.";
hascmd npm || sudo pacman -Sy npm
sudo npm -g install bash-language-server pyright typescript-language-server vscode-langservers-extracted
sudo pacman -S zig zls ruff clang
