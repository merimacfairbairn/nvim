return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = function()
    vim.keymap.set("n", "<space>u", vim.cmd.UndotreeToggle)
  end,
}
