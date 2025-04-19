return {
  dir = "~/projects/plugins/autoformat.nvim/",
  name = "autoformat",
  lazy = false,
  config = function()
    require("autoformat").setup()
    vim.keymap.set("n", "<Leader>tf", "<cmd>AutoformatToggleFile<cr>")
  end
}
