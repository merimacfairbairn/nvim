return {
    "folke/trouble.nvim",
    opts = {
        icons = false,
    },

    keys = function()
        vim.keymap.set("n", "<leader>tt", function()
            require("trouble").toggle()
        end)
        vim.keymap.set("n", "[d", function()
            require("trouble").next({skip_group = true, jump = true})
        end)
        vim.keymap.set("n", "]d", function()
            require("trouble").previous({skip_group = true, jump = true})
        end)
    end,

    config = true,
}
