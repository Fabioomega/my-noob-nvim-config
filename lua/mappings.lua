require "nvchad.mappings"

local function toggle_nvim_tree()
  local api = require "nvim-tree.api"
  local view = require "nvim-tree.view"

  if view.is_visible() then
    api.tree.close()
  else
    api.tree.open()
  end
end

local map = vim.keymap.set

map("n", "<leader>e", toggle_nvim_tree, { noremap = true, silent = true, desc = "Open nvim-tree" })

map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

map("n", "<leader>E", function()
  require("telescope.builtin").diagnostics {
    severity = vim.diagnostic.severity.ERROR,
  }
end, { desc = "Show buffer errors" })

map("n", "<leader><leader>", function()
  require("telescope.builtin").find_files()
end, { noremap = true, silent = true })

-- Adds format behavior and leaves visual mode when format range was performed
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

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Shift + Arrow keys to enter Visual mode in that direction
map("n", "<S-Left>", "v<Left>", { desc = "Visual left" })
map("n", "<S-Right>", "v<Right>", { desc = "Visual right" })
map("n", "<S-Up>", "v<Up>", { desc = "Visual up" })
map("n", "<S-Down>", "v<Down>", { desc = "Visual down" })

-- Continue selection while in visual mode
map("v", "<S-Left>", "<Left>", { desc = "Select left" })
map("v", "<S-Right>", "<Right>", { desc = "Select right" })
map("v", "<S-Up>", "<Up>", { desc = "Select up" })
map("v", "<S-Down>", "<Down>", { desc = "Select down" })

-- Custom commands
local create_cmd = vim.api.nvim_create_user_command

create_cmd("FormatToggle", function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  print("Autoformat " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
end, {})
