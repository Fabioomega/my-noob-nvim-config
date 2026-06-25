return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = require("configs.conform"),
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				-- LSP servers
				"lua-language-server",
				"html-lsp",
				"css-lsp",
				"clangd",
				"ty",
				"rust-analyzer",
				"typos-lsp",
				-- Formatters
				"stylua",
				"clang-format",
				"prettier",
			},
		},
	},
	{
		"mrcjkb/rustaceanvim",
		lazy = false, -- This plugin is already lazy
	},
	{
		"tpope/vim-fugitive",
		cmd = {
			"Git",
			"Gdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		opts = function()
			local opts = require("nvchad.configs.nvimtree")

			opts.filters.git_ignored = false

			return opts
		end,
	},
	{
		"Chaitanyabsprip/fastaction.nvim",
		---@type FastActionConfig
		opts = {},
	},
}
