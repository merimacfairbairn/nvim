return {
    "folke/trouble.nvim",
    opts = {
        icons = false,
    },

    keys = function()
        local trouble = require("trouble")
        trouble.Mode = "diagnostics"
        vim.keymap.set("n", "<leader>tt", function()
            trouble.toggle()
        end)
        vim.keymap.set("n", "[d", function()
            trouble.next({ skip_group = true, jump = true })
        end)
        vim.keymap.set("n", "]d", function()
            trouble.previous({ skip_group = true, jump = true })
        end)
    end,

    config = true,
}
