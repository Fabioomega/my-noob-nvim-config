---@module "conform"
---@type conform.setupOpts
local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" }
    -- css = { "prettier" },
    -- html = { "prettier" },
  },
  default_format_opts = {
      lsp_format = "fallback",
  },
  format_on_save = function (bufnr)
    if vim.g.disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end
}

return options
