return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },

  config = function()
    require("telescope").setup({
      defaults = {
        path_display = {
          filename_first = {
            reverse_directories = true
          },
        },
      },
      pickers = {
        find_files = {
          disable_devicons = true
        },
        git_files = {
          disable_devicons = true
        },
        grep_string = {
          disable_devicons = true
        },
        live_grep = {
          disable_devicons = true
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          }
        }
      },
    })

    require("telescope").load_extension("fzf")
  end,
  keys = function()
    local builtin = require('telescope.builtin')
    local themes = require('telescope.themes')

    -- Find
    vim.keymap.set('n', '<space>pf', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    require("plugins.telescope.multigrep").setup()

    vim.keymap.set('n', '<space>ep', function()
      builtin.find_files({
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
      })
    end)

    vim.keymap.set('n', '<space>vh', builtin.help_tags, {})

    -- LSP
    vim.keymap.set("n", "<Leader>vrr", builtin.lsp_references, {})
    vim.keymap.set("n", "gd", function()
      builtin.lsp_definitions(themes.get_dropdown())
    end, {})
    vim.keymap.set("n", "<Leader>vws", function()
      builtin.lsp_workspace_symbols(themes.get_dropdown())
    end, {})
    vim.keymap.set("n", "<space>tt", function()
      builtin.diagnostics(themes.get_ivy())
    end, {})

    vim.keymap.set("n", "z=", function()
      builtin.spell_suggest(themes.get_cursor())
    end, {})
  end,
}
