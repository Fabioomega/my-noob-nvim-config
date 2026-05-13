require("nvchad.mappings")

local map = vim.keymap.set

map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Opens telescope with diagnostics set to error
map("n", "<leader>E", function()
	require("telescope.builtin").diagnostics({
		severity = vim.diagnostic.severity.ERROR,
	})
end, { desc = "Show buffer errors" })

-- Adds format behavior and leaves visual mode when format range was performed fudge
map("", "<leader>F", function()
	require("conform").format({ async = true }, function(err)
		if not err then
			local mode = vim.api.nvim_get_mode().mode
			if vim.startswith(string.lower(mode), "v") then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
			end
		end
	end)
end, { desc = "Format code" })

-- Opens a LSP diagnostics locklist with workspace-wide errors
map("n", "<leader>dE", function()
	vim.diagnostic.setqflist({
		severity = vim.diagnostic.severity.ERROR,
	})
end, { desc = "LSP diagnostic locklist (workspace-wide errors)" })

-- Adds find the references of a symbol
map("n", "<leader>fR", function()
	require("telescope.builtin").lsp_references({
		reuse_win = true,
	})
end, { desc = "telescope find references" })

-- Shows the contents of all registers
map("n", "<leader>fr", require("telescope.builtin").registers, { desc = "telescope show registers" })

map({ "n", "x" }, "<leader>ca", require("fastaction").code_action, { desc = "Display code actions" })

map("n", ";", ":", { desc = "CMD enter command mode" })
-- When <ESC> is pressed exit insert mode in the terminal
map("i", "jk", "<ESC>")

-- Toggle display hints
map("n", "<leader>lh", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "toggle display hints" })
