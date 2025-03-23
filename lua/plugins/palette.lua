return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    vim.o.background = "dark"
    function ColorDefault(color)
      color = color or "gruvbox"
      vim.cmd.colorscheme(color)
    end

    ColorDefault()
  end,
  opts = {
    transparent_mode = true
  },
}
