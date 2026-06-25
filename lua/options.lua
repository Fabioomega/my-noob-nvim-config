require("nvchad.options")

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- vim.opt.foldnestmax = 4

vim.opt.pumheight = 10

vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "noplainbuffer,camel"
vim.opt.spell = true
