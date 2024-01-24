return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        icons = false,
    },
    config = function()
        vim.keymap.set("n", "<leader>tt", function()
            require("trouble").toggle()
        end)
        vim.keymap.set("n", "[d", function()
            require("trouble").next({skip_group = true, jump = true})
        end)
        vim.keymap.set("n", "]d", function()
            require("trouble").previous({skip_group = true, jump = true})
        end)
    end
}
