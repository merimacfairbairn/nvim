return {
  'nvim-orgmode/orgmode',
  dependencies = {
    "nvim-orgmode/org-bullets.nvim",
    "lukas-reineke/headlines.nvim",
    "danilshvalov/org-modern.nvim",
    "chipsenkbeil/org-roam.nvim",
  },
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    require("org-roam").setup({
      directory = "~/documents/orgroam",
      extensions = {
        dailies = {
          directory = "~/documents/orgroam/journal",
        },
      },
    })
    local Menu = require("org-modern.menu")
    require('orgmode').setup({
      org_agenda_files = '~/documents/orgfiles/**/*',
      org_default_notes_file = '~/documents/orgfiles/refile.org',

      mappings = {
        prefix = "<space>o",
      },

      org_todo_keywords = { "TODO(t)", "|", "DONE(d)", "CANCELLED(c)" },

      ui = {
        menu = {
          handler = function(data)
            Menu:new({
              window = {
                border = "",
              },
            }):open(data)
          end,
        },
      },

      notifications = {
        enabled = true,
      },
    })

    require("headlines").setup({
      markdown = {
        headline_highlights = false,
      },
    })

    vim.keymap.set("n", "<space>oa", "<cmd>Org agenda<cr>")
    vim.keymap.set("n", "<space>oc", "<cmd>Org capture<cr>")
  end,
}
