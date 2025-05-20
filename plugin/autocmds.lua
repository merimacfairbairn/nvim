local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufWritePre" }, {
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<Leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    vim.keymap.set("n", "<Leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<Leader>vrn", function() vim.lsp.buf.rename() end, opts)
  end
})

local yankGroup = vim.api.nvim_create_augroup('HighLightYank', {})
autocmd('TextYankPost', {
  group = yankGroup,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

autocmd("FileType", {
  pattern = { "pandoc", "markdown", "text" },
  callback = function()
    vim.keymap.set("n", "<space>tf", [[vip:'<,'>! tr -s " " | column -t -s '|' -o '|'<CR><ESC>]], { buffer = 0 })
  end,
})
