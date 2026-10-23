return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.o.background = "dark"
    function ColorDefault(color)
      color = color or "catppuccin-mocha"
      vim.cmd.colorscheme(color)
    end

    ColorDefault()
  end,
  opts = {
    transparent_mode = true,

    flavour = "mocha",
  },
}
