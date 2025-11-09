---@module "conform"
---@type conform.setupOpts
local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		vue = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = function(bufnr)
		if vim.g.disable_autoformat then
			return
		end
		return { timeout_ms = 500, lsp_fallback = true }
	end,
}

return options
