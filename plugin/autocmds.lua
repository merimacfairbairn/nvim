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

local group = vim.api.nvim_create_augroup("autosave", {})

-- Notification to say when a file is saved by autosave
vim.api.nvim_create_autocmd("User", {
  pattern = "AutoSaveWritePre",
  group = group,
  callback = function(opts)
    if opts.data.saved_buffer ~= nil then
      local filename = vim.fn.expand("%:t")
      vim.notify("Saved '" .. filename .. "' at " .. vim.fn.strftime("%H:%M:%S"))
    end
  end,
})

-- Notification when enabling/disabling autosave for a buffer
vim.api.nvim_create_autocmd("User", {
  pattern = "AutoSaveEnable",
  group = group,
  callback = function()
    vim.notify("AutoSave enabled")
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "AutoSaveDisable",
  group = group,
  callback = function()
    vim.notify("AutoSave disabled")
  end,
})
