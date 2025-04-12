return {
  "norcalli/nvim-colorizer.lua",

  cmd = "ColorizerToggle",

  keys = function()
    vim.keymap.set("n", "<space>col", vim.cmd.ColorizerToggle)
  end,

  opts = {
    "*",
    css = {
      css = true,
    },
    less = {
      css = true,
    },
    html = {
      names = true,
    },
  },

  ft = {
    "scss",
    "css",
    "html",
    "conf",
  }
};
