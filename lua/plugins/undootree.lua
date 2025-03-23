return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = function()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
  end,
}
