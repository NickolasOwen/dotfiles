-- Basic Vim Settings
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.relativenumber = true
vim.opt.linebreak = true
vim.opt.colorcolumn = "80,120"
vim.opt.textwidth=120
vim.opt.scrolloff = 10
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "number"
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.have_nerd_font = true

-- Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = ' '
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Highlight Yanks
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Custom Run
vim.keymap.set("n", "<F5>", function()
  os.execute('pwsh /home/bear/projects/github.com/NickolasOwen/nebulous/scripts/rebuild.ps1')
end)

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
  {
    'derektata/lorem.nvim',
    config = function()
        require('lorem').opts {
            sentenceLength = "medium",
            comma_chance = 0.2,
            max_commas_per_sentence = 2,
        }
    end
  },
  -- Color Themes
  { "sainnhe/sonokai", name = "sonokai", lazy = false, priority = 1000 },
  --
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    init_options = {
      userLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        rust = "html",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- Astro
  {
    "wuelnerdotexe/vim-astro"
  },
  -- Window Manager Config
  {"baskerville/vim-sxhkdrc"},
  --
  { 'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    end,
    defaults = { file_ignore_patterns = {"node_modules", "target", "dist"} },
  },
  { "j-hui/fidget.nvim" },
  { "tpope/vim-sleuth" },
  {'glepnir/template.nvim', cmd = {'Template','TemProject'}, config = function()
      require('template').setup({
          -- config in there
        temp_dir = '~/.config/nvim/templates',
        author = 'Nick Owen',   -- your name
        email = 'nickolas.owen@protonmail.com'    -- email address
      })
    end
  },
  { "terrortylor/nvim-comment" },

  {  -- Autocomplete
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      signature = { enabled = true },
      keymap = { preset = 'default' },

      appearance = {
        nerd_font_variant = 'mono'
      },

      completion = { documentation = { auto_show = true } },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
}

-- vim.pack.add{
--   { src = 'https://github.com/neovim/nvim-lspconfig' },
-- }

local opts = {}
-- Initialize plugins
require("lazy").setup(plugins, opts)
require("mason").setup()

vim.lsp.enable({ "html", "lua_ls", "rust_analyzer", "bashls", "yamlls", "marksman", "powershell_es", "cssls", "astro", "vue_ls", "vtsls" })

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

vim.lsp.config("vtsls", {
  filetypes = { "typescript", "javascript", "vue" }
})

require("fidget").setup()
require('nvim_comment').setup()

-- Set colorscheme
vim.cmd.colorscheme "sonokai"

vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])

-- Treesitter
local configs = require("nvim-treesitter.configs")
configs.setup({
  ensure_installed = { "lua", "vim", "vimdoc", "javascript", "html", "css", "yaml", "markdown", "rust", "astro", "vue", "typescript" },
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
vim.keymap.set( 't', '<leader><Esc>', '<C-\\><C-n>', {noremap = true} )
vim.keymap.set( 't', '<Esc><Esc>', '<C-\\><C-n>', {noremap = true} )
vim.keymap.set( 'n', '<leader>fb', builtin.buffers, {} )

-- Template Keybinds
vim.keymap.set('n', '<Leader>tpl', function()
    vim.fn.feedkeys(':Template ')
end, { remap = true})

-- LSP Keybinds
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementations()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })

-- Prettier
vim.api.nvim_set_keymap("n", "<leader>pf", "<cmd>%!prettier --stdin-filepath %<CR>", { noremap = true, silent = true })

-- My Favs
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>\\", ":vert sb<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>-", ":bot sb<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>h", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>j", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>k", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>l", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>s", "<C-w>-", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>t", "<C-w>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>n", "<C-w><", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>w", "<C-w>>", { noremap = true, silent = true })

