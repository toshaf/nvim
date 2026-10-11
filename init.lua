-- plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git", "--branch=stable",
		lazypath})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"ibhagwan/fzf-lua",
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- file icons, requires a Nerd font
			"MunifTanjim/nui.nvim",
		}
	},
    { "neanias/everforest-nvim" },
    { "dzfrias/noir.nvim" },
    { "FabijanZulj/blame.nvim" },
    { "stevearc/conform.nvim" },
})

require("conform").setup({
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    rust = { "rustfmt" },
  },
  format_on_save = { timeout_ms = 1000, lsp_format = "never" ),
})

require("blame").setup({ })

require("neo-tree").setup({
	filesystem = {
		follow_current_file = { enabled = true },
	},
	window = {
		width = 30,
		mappings = {
			["l"] = "open",
			["h"] = "close_node",
		}
	},
})

-- general
vim.g.mapleader = " "
vim.opt.tabstop = 2 -- width of tab
vim.opt.shiftwidth = 2 -- how much to indent with >>
vim.opt.expandtab = true -- spaces over tabs
vim.keymap.set("n", "<Esc>", "<Cmd>noh<CR>")
--vim.cmd("syntax off")
vim.cmd.colorscheme("noir")
vim.cmd("set number")
vim.cmd("set cursorline")

-- seraching
vim.o.ignorecase = true
vim.o.smartcase = true

-- buffers
vim.keymap.set("n", "<S-h>", "<Cmd>bprevious<CR>")
vim.keymap.set("n", "<S-l>", "<Cmd>bnext<CR>")

-- neo-tree
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")

-- fzf-lua
local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>f", fzf.files)
vim.keymap.set("n", "<leader>F", function()
  fzf.files({ cwd = vim.fn.expand("%:p:h") })
end)
vim.keymap.set("n", "<leader>g", fzf.live_grep)
vim.keymap.set("n", "<leader>G", function()
  fzf.live_grep({ cwd = vim.fn.expand("%:p:h") })
end)
vim.keymap.set("n", "<leader>b", fzf.buffers)
vim.keymap.set("n", "<leader>r", fzf.registers)

-- blame
vim.keymap.set("n", "<leader>w", "<Cmd>Blame<CR>")
