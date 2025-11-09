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

vim.api.nvim_create_user_command("Config", function()
	-- Open the config directory in Neovim
	vim.cmd("cd " .. config_path)
	vim.cmd("edit " .. config_path)
end, { desc = "Open Neovim config folder" })

vim.api.nvim_create_user_command("DieDocker", function()
	local os_name = vim.loop.os_uname().sysname
	local cmd

	if os_name == "Windows_NT" then
		cmd = { "powershell", "-Command", "docker ps -q | ForEach-Object { docker stop $_ }" }
	else
		cmd = { "sh", "-c", "docker stop $(docker ps -q)" }
	end

	vim.system(cmd, { text = true }, function(obj)
		if obj.code == 0 then
			vim.schedule(function()
				vim.notify("✅ All Docker containers stopped successfully.", vim.log.levels.INFO)
			end)
		else
			vim.schedule(function()
				vim.notify("❌ Failed to stop Docker containers:\n" .. (obj.stderr or ""), vim.log.levels.ERROR)
			end)
		end
	end)
end, {})
