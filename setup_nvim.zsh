#!/usr/bin/env zsh
(( $+programs[nvim] )) || echo "NeoVim is not installed. Follow README.md"
curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp "${0:A:h}/init.lua" "$HOME/.config/nvim/init.lua"
nvim +PlugInstall +qall
nvim +"lua require('nvim-treesitter').install({ 'python', 'c', 'cpp', 'bash', 'html', 'css', 'javascript', 'zig' })" +qall
