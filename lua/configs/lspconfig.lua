require("nvchad.configs.lspconfig").defaults()

vim.lsp.inlay_hint.enable(true)

local vue_language_server_path = vim.fn.stdpath("data")
	.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}

local vtsls_config = {
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
	filetypes = tsserver_filetypes,
}

vim.lsp.config("vtsls", vtsls_config)

local servers = { "html", "cssls", "ty", "clangd", "vtsls", "vue_ls", "harper_ls" }
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
