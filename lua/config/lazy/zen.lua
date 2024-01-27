return{
    "folke/zen-mode.nvim",

    opts = {
        window = {
            width = 90,
        },
        plugins = {
            options = {
                laststatus = 3
            },
        },
    },

    config = true,

    keys = {
        vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").toggle()
        end)
    },
}
