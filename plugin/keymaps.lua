local set = vim.keymap.set

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set("n", "p", function()
  local row, cursor = unpack(vim.api.nvim_win_get_cursor(0))
  vim.cmd("put")
  vim.api.nvim_win_set_cursor(0, { row + 1, cursor })
end)

set("n", "P", function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.cmd("normal! P")
  vim.api.nvim_win_set_cursor(0, { row, col })
end)

set("x", "<space>p", [["_dP]])

set({ "n", "v" }, "<space>y", [["+y]])
set("n", "<space>Y", [["+Y]])

set({ "n", "v" }, "<space>d", [["_d]])

set("n", "Q", "<nop>")
set("n", "<Leader>f", vim.lsp.buf.format)

set("n", "<C-k>", "<cmd>cnext<CR>zz")
set("n", "<C-j>", "<cmd>cprev<CR>zz")
set("n", "<space>k", "<cmd>lnext<CR>zz")
set("n", "<space>j", "<cmd>lprev<CR>zz")

set("i", "<C-c>", "<Esc>")

set("n", "<space>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

set("n", "<Leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

set("n", "<Leader><Leader>", function()
  vim.cmd("w|so %")
end)
