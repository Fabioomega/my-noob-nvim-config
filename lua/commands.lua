local create_cmd = vim.api.nvim_create_user_command

create_cmd("FormatToggle", function()
	vim.g.disable_autoformat = not vim.g.disable_autoformat
	print("Autoformat " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
end, {})

-- Detect OS and set config path
local config_path
if vim.uv.os_uname().sysname == "Windows_NT" then
	config_path = os.getenv("LOCALAPPDATA") .. "\\nvim"
else
	config_path = vim.fn.expand("~/.config/nvim")
end

-- Create the :Config command
vim.api.nvim_create_user_command("Config", function()
	-- Open the config directory in Neovim
	vim.cmd("cd " .. config_path)
	vim.cmd("edit " .. config_path)
end, { desc = "Open Neovim config folder and set it as working directory" })
