vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<ESC>Oreturn err<ESC>",
    { buffer = 0 }
)

