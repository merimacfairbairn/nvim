return {
    "gaoDean/autolist.nvim",
    ft = {
        "markdown",
        "text",
    },
    config = function()
        -- Default patterns
        local list_patterns = {
            neorg_1 = "%-",
            neorg_2 = "%-%-",
            neorg_3 = "%-%-%-",
            neorg_4 = "%-%-%-%-",
            neorg_5 = "%-%-%-%-%-",
            unordered = "[-+*]", -- - + *
            digit = "%d+[.)]",   -- 1. 2. 3.
            ascii = "%a[.)]",    -- a) b) c)
            roman = "%u*[.)]",   -- I. II. III.
            latex_item = "\\item",
        }

        require("autolist").setup({
            lists = {     -- configures list behaviours
                -- Each key in lists represents a filetype.
                -- The value is a table of all the list patterns that the filetype implements.
                -- See how to define your custom list below in the readme.
                -- You must put the file name for the filetype, not the file extension
                -- To get the "file name", it is just =:set filetype?= or =:se ft?=.
                pandoc = {
                    list_patterns.unordered,
                    list_patterns.digit,
                    list_patterns.ascii,     -- for example this specifies activate the ascii list
                    list_patterns.roman,     -- type for markdown files.
                },
            }
        })

        vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
        vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
        vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
        vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
        vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
        vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
        vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
        vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")

        -- cycle list types with dot-repeat
        vim.keymap.set("n", "<leader>cn", require("autolist").cycle_next_dr, { expr = true })
        vim.keymap.set("n", "<leader>cp", require("autolist").cycle_prev_dr, { expr = true })

        -- if you don't want dot-repeat
        -- vim.keymap.set("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>")
        -- vim.keymap.set("n", "<leader>cp", "<cmd>AutolistCycleNext<cr>")

        -- functions to recalculate list on edit
        vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
        vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
        vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
        vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
    end,
}
