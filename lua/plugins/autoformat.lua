return {
  dir = "~/projects/plugins/autoformat.nvim/",
  name = "autoformat",
  branch = "main",
  lazy = false,
  config = function()
    require("autoformat").setup({
      always_block = {
        files = {},
        filetypes = { "htmldjango" },
        projects = {},
      },
    })

    local af = require("autoformat")
    local ui = require("autoformat.ui")
    vim.keymap.set("n", "<Leader>af", ui.toggle_menu, { noremap = true, silent = true })
    vim.keymap.set("n", "<Leader>fa", af.toggle_file, { noremap = true, silent = true })
    vim.keymap.set("n", "<Leader>ft", af.toggle_ft, { noremap = true, silent = true })
    vim.keymap.set("n", "<Leader>fs", af.toggle_project, { noremap = true, silent = true })
  end
}
