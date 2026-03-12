#!/usr/bin/env zsh
hascmd() { (( $+commands[$1] )) }
hascmd npm || apt install npm
npm -g install bash-language-server pyright typescript-language-server vscode-langservers-extracted
apt install zig zls ruff clang
