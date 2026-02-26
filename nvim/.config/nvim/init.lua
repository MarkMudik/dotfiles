vim.opt.mouse = ""
vim.opt.swapfile = false
vim.cmd([[hi @lsp.type.number gui=italic]])
vim.opt.winborder = "rounded"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.showtabline = 2
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.number = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.pack.add({
	{ src = "https://github.com/miikanissi/modus-themes.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter",        version = "main" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim",          version = "0.1.8" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" }
})

local default_color = "modus_operandi"
local map = vim.keymap.set
vim.cmd('colorscheme ' .. default_color)

-- oil
require("oil").setup({
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
	columns = {
		"icon",
	},
	float = {
		max_width = 0.3,
		max_height = 0.6,
		border = "rounded",
	},
})

map({ "n" }, "<leader>e", "<cmd>Oil<CR>")

-- Telescope
local builtin = require('telescope.builtin')

require('telescope').setup({
  defaults = {
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }, -- Matches your rounded theme
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
  },
})

map('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })

-- LSP
require("mason").setup()

vim.lsp.enable({
  "html",
  "cssls",
  "ts_ls"
})

-- Better UI for the completion menu
vim.opt.completeopt = { "menuone", "noselect", "popup" }

-- Run this code whenever an LSP connects to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my_lsp_setup', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    
    -- Enable native Neovim autocompletion
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    -- Essential LSP Keymaps (only active when LSP is attached)
    local opts = { buffer = event.buf, silent = true }
    
    -- Press 'K' to view hover documentation
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    
    -- Press 'gd' to jump to a definition
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    
    -- Press '<leader>la' to view available code actions
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts)
  end,
})
