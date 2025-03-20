return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        skip_confirm_for_simple_edits = true,

        lsp_file_methods = {
            autosave_changes = true,
        },
    },

    config = function()
        require("oil").setup()
        vim.keymap.set("n", "<leader>pv", "<cmd>Oil<cr>")
    end,
    lazy = false,
}
