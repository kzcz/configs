# What is this repo
A collection of the setup info of my systems to inspire other people, and/or let them take this as a reference for their own system.
# Installation
I recommend examining the files and making any desired changes.  
**Note**: This branch is aimed specifically at termux, for general desktop usage, use the main branch instead. 
1. Clone this repo
2. Install dependencies
3. `cp ./bash.bashrc $PREFIX/etc/bash.bashrc`
4. `cp ./zshrc.zsh $PREFIX/etc/zshrc`
5. `./install_ls.zsh`
6. `./setup_nvim.zsh`
7. `exec $SHELL` to reload your shell
## Dependencies
- One of zsh or bash
- zsh-syntax-highlighting if using zsh
- neovim and neovim-treesitter
- npm
### How to install zsh-syntax-highlighting
1. Clone the [repo](https://github.com/zsh-users/zsh-syntax-highlighting)
2. `make install`
### Neovim language servers
- clangd
- bash-language-server (npm)
- pyright (npm)
- zls
- vscode-langservers-extracted (npm)
- typescript-language-server (npm)
- ruff
# Once installed
`vim-plug` will be installed, and neovim will have the above language servers configured, along with the gruvbox theme.  
The shell prompt will be changed.  
The function `wp` will be available for both shells, with completions available for zsh.  
## Aliases
- `ls` (colored)
- `ll`
- `grep` (colored)
- `nv` (neovim)
- `rgc` (reload global config)
- `rec` (reload environment)
- `rzc` (zsh only)
- `rbc` (bash only)
## See also
Consider checking out [PJM](https://github.com/kzcz/pjm)
# License
This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](./LICENSE) file for details.
# Contact
Discord: @puc3  
Email: cursitical@gmail.com
