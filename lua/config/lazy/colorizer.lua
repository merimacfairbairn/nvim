return {
    "norcalli/nvim-colorizer.lua",

    cmd = "ColorizerToggle",
    keys = function()
        vim.keymap.set("n", "<leader>col", vim.cmd.ColorizerToggle)
    end,
    config = true,
    opts = {
        "*",
        css = {
            css = true,
        },
        html = {
            names = true,
        },
    };
};
