vim.keymap.set('i', '<S-CR>', '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
  silent = true,
  buffer = true,
})

vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
