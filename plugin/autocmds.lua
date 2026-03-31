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


-- Update on CursorMoved
vim.api.nvim_create_autocmd({"CursorMoved", "BufEnter"}, {
  callback = function()
    local ns = vim.api.nvim_create_namespace("cell_highlight")

    local function highlight_current_cell()
      vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
      local cur = vim.fn.line(".")
      local start_line = vim.fn.search("^# %%", "bnW")
      if start_line == 0 then start_line = 1 end
      local end_line = vim.fn.search("^# %%", "nW")
      if end_line == 0 then end_line = vim.fn.line("$") + 1 end

      vim.api.nvim_buf_add_highlight(0, ns, "Visual", start_line - 1, 0, -1)
      vim.api.nvim_buf_add_highlight(0, ns, "Visual", end_line - 1, 0, -1)
    end

    -- Update on CursorMoved
    vim.api.nvim_create_autocmd({"CursorMoved", "BufEnter"}, {
      callback = highlight_current_cell,
    })
  end
})
