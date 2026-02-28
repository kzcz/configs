vim.cmd [[
call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'morhetz/gruvbox'
Plug 'ziglang/zig.vim'
Plug 'mattn/emmet-vim'
Plug 'windwp/nvim-ts-autotag'
Plug 'dcampos/cmp-emmet-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'branch': 'main'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects', {'branch': 'main'}
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
call plug#end()
]]

require('mason').setup()
require('mason-lspconfig').setup()
require'nvim-ts-autotag'.setup()
-- require('nvim-treesitter').install({ 'python', 'c', 'cpp', 'bash', 'html', 'css', 'javascript', 'zig' })
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function(args)
    local ok, _ = pcall(vim.treesitter.start, args.buf)
    if ok then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

local opts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
vim.keymap.set('n', '<leader>e', vim.cmd.bnext, opts)
vim.keymap.set('n', '<leader>q', vim.cmd.bprev, opts)

local caps = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('clangd', { capabilities = caps })
vim.lsp.config('bashls', { capabilities = caps })
vim.lsp.config('pyright', { capabilities = caps })
vim.lsp.config('zls', { capabilities = caps })
vim.lsp.config('html', { capabilities = caps })
vim.lsp.config('cssls', { capabilities = caps, filetypes = { "css", "scss", "less" } })
vim.lsp.config('ts_ls', { capabilities = caps, filetypes = { "html", "javascript", "typescript" }})
vim.lsp.config('ruff', { cmd = { "ruff", "server" }, filetypes = { "python" }, capabilities = caps, init_options = {
    settings = {
        lineLength = 88,
    }
})

vim.lsp.enable('clangd')
vim.lsp.enable('bashls')
vim.lsp.enable('pyright')
vim.lsp.enable('zls')
vim.lsp.enable('html')
vim.lsp.enable('cssls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('ruff')

local cmp=require'cmp'
cmp.setup({
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-\\>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true })
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'emmet-vim' },
        { name = 'buffer' },
        { name = 'path' }
    }
})

require('nvim-treesitter-textobjects').setup({
  select = { enable = true, lookahead = true },
  move = { enable = true, set_jumps = true },
})

vim.cmd('colorscheme gruvbox')
vim.o.background = 'dark'

