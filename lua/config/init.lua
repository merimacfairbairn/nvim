require("config.remap")
require("config.set")
require("config.status")

-- autocmd's
local autocmd = vim.api.nvim_create_autocmd
autocmd({"BufWritePre"}, {
    pattern = '*',
    command = [[%s/\s\+$//e]],
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
