return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },

    config = function()
        require("telescope").setup({
            pickers = {
                find_files = {
                    disable_devicons = true
                },
                git_files = {
                    disable_devicons = true
                },
                grep_string = {
                    disable_devicons = true
                },
                live_grep = {
                    disable_devicons = true
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            },
        })

        require("telescope").load_extension("fzf")
    end,
    keys = function()
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word });
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word });
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.live_grep();
        end)

        vim.keymap.set('n', '<leader>ep', function()
            builtin.find_files({
                cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
            })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end,
}
