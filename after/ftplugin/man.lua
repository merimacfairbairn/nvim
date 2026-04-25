local set = vim.keymap.set
local oloc = vim.opt_local

-- # Keymaps
set("n", "j", "j", { buffer = true })
set("n", "k", "k", { buffer = true })

-- # Opts

-- Visual
oloc.wrap = true
oloc.linebreak = true

-- UI noise
oloc.number = false
oloc.relativenumber = false
oloc.signcolumn = 'no'
oloc.colorcolumn = ""

-- Enable folds
vim.g.ft_man_folding_enable = true
oloc.shiftwidth = 2
oloc.tabstop = 2
oloc.foldmethod = "indent"
oloc.foldnestmax = 1
