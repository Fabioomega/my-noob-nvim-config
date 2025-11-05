require("nvchad.configs.lspconfig").defaults()

vim.lsp.inlay_hint.enable(true)

local servers = { "html", "cssls", "ty", "clangd" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
local util = require("lspconfig.util")

local use_root_fallback = { "ty", "clangd" }

for i = 1, #use_root_fallback do
	local server_name = use_root_fallback[i]

	local based_cfg = vim.lsp.config[server_name]

	vim.lsp.config(server_name, {
		root_dir = function(bufnr, on_dir)
			local workdir = util.root_pattern(unpack(based_cfg.root_markers))(bufnr) or vim.uv.cwd()
			on_dir(workdir)
		end,
	})
end
