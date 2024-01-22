vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").setup {
        window = {
            width = 90,
        },
        plugins = {
            options = {
                laststatus = 3
            },
        },
    }
    require("zen-mode").toggle()
end)
