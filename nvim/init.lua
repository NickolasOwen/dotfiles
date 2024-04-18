-- Basic Vim Settings
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")
vim.cmd("set linebreak")
vim.cmd("set colorcolumn=80,120")
vim.cmd("set textwidth=120")
vim.g.mapleader = " "

-- Download/Install Lazy Plugin Manager Automatically
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", --latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Declare plugins for automatic install
local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig"
  },
  { 'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { "j-hui/fidget.nvim" },
  {'glepnir/template.nvim', cmd = {'Template','TemProject'}, config = function()
      require('template').setup({
          -- config in there
        temp_dir = '~/.config/nvim/templates',
        author = 'Nick Owen',   -- your name
        email = 'nickolas.owen@protonmail.com'    -- email address
      })
    end
  },
}
local opts = {}

-- Initialize plugins
require("lazy").setup(plugins, opts)
require("catppuccin").setup()
require("mason").setup()
require("mason-lspconfig").setup{
  ensure_installed = { "lua_ls", "powershell_es", "yamlls" }
}
require("fidget").setup()

-- LSP
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    },
  },
}
lspconfig.powershell_es.setup {}
lspconfig.yamlls.setup {}

-- Set colorscheme
vim.cmd.colorscheme "catppuccin"

-- Treesitter
local configs = require("nvim-treesitter.configs")
configs.setup({
  ensure_installed = { "lua", "vim", "vimdoc", "javascript", "html", "css", "yaml" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set( 'n', '<leader>fb', builtin.buffers, {} )
vim.keymap.set( 't', '<leader>fb', builtin.buffers, {noremap = true} )

-- Terminal Keybinds
vim.keymap.set( 't', '<leader><ESC>', '<C-\\><C-n>', {noremap = true} )
vim.keymap.set( 'n', '<leader>fb', builtin.buffers, {} )
