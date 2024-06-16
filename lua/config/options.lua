-- vim options
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- netrw options
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- status line options
vim.api.nvim_set_hl(0, 'User1', { fg = "#d79921", bg = "#3c3836" })
vim.api.nvim_set_hl(0, 'User2', { fg = "#fb4924", bg = "#3c3836" })
vim.api.nvim_set_hl(0, 'User3', { fg = "#b8bb26", bg = "#3c3836" })

vim.opt.statusline = [[%2*%2M%*]]
vim.opt.statusline:append([[%3* %<%F%*]])

vim.opt.statusline:append([[%1*%=%*]])

vim.opt.statusline:append([[%3* %Y%*]])
vim.opt.statusline:append([[%1*%5l%*]])
vim.opt.statusline:append([[%2*/%L%*]])
vim.opt.statusline:append([[%1*%4v %*]])

vim.opt.laststatus = 2
vim.opt.wildmenu = true
vim.opt.wildignore = { "*.docx", "*.jpg", "*.png", "*.gif", "*.pdf", "*pyc", "*.e" }
