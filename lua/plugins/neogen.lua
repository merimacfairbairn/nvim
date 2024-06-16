return{
    "danymat/neogen",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "L3MON4D3/LuaSnip",
    };
    opts = {
        snippet_engine = "luasnip",
    },
    config = true,

    keys = function()
        vim.keymap.set("n", "<leader>nf", function ()
            require("neogen").generate({ type = "func" })
        end)
        vim.keymap.set("n", "<leader>nt", function ()
            require("neogen").generate({ type = "type" })
        end)
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
}
