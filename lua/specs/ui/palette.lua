return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function(_, opts)
      vim.o.background = "dark"
      function ColorDefault(color)
        color = color or "catppuccin-mocha"
        vim.cmd.colorscheme(color)
      end

      require("catppuccin").setup(opts)

      ColorDefault()
    end,
    opts = {
      transparent_mode = true,

      flavour = "mocha",
    },
  },
  {
    "tadaa/vimade",
    opts = {
      recipe = {
        "minimalist",
        animate = true,
      },

      fadelevel = 0.8,
    },
  },
}
