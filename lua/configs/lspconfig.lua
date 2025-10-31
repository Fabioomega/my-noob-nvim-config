require("nvchad.configs.lspconfig").defaults()

vim.lsp.inlay_hint.enable(true)

local servers = { "html", "cssls", "ty" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers

local util = require("lspconfig.util")
local based_cfg = vim.lsp.config.ty

vim.lsp.config("ty", {
	root_dir = function(bufnr, on_dir)
		local workdir = util.root_pattern(unpack(based_cfg.root_markers))(bufnr) or vim.uv.cwd()
		on_dir(workdir)
	end,
})
