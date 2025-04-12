vim.keymap.set(
    "n",
    "<space>ee",
    "oif err != nil {<CR>}<ESC>Oreturn err<ESC>",
    { buffer = 0 }
)
