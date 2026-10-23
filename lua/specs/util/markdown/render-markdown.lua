  return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      preset = "obsidian",
      completions = {
        blink = { enabled = true }
      },
      code = {
        enabled = true,
        conceal_delimiters = false,
        language = true,
        sign = true,
        language_icon = true,
        language_name = true,
        language_info = false,
        border = "thick",
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
    end
  }
