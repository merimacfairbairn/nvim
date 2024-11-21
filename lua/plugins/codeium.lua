return {
  'Exafunction/codeium.vim',
  event = "BufEnter",
  config = function ()
    vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-l>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-r>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-f>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })
  end
}
