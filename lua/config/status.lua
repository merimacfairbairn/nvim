vim.api.nvim_set_hl(0, 'User1', { fg="#d79921", bg="#3c3836" })
vim.api.nvim_set_hl(0, 'User2', { fg="#fb4924", bg="#3c3836" })
vim.api.nvim_set_hl(0, 'User3', { fg="#b8bb26", bg="#3c3836" })

vim.opt.statusline=[[%2*%2M%*]]
vim.opt.statusline:append([[%3* %<%F%*]])

vim.opt.statusline:append([[%1*%=%*]])

vim.opt.statusline:append([[%3* %Y%*]])
vim.opt.statusline:append([[%1*%5l%*]])
vim.opt.statusline:append([[%2*/%L%*]])
vim.opt.statusline:append([[%1*%4v %*]])

vim.opt.laststatus=2
vim.opt.wildmenu = true
vim.opt.wildignore={"*.docx","*.jpg","*.png","*.gif","*.pdf","*pyc","*.e"}
