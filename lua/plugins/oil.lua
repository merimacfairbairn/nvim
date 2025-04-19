return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = false,

    watch_for_changes = true,

    lsp_file_methods = {
      autosave_changes = true,
    },

    use_default_keymaps = false,
    keymaps = {
      ["g?"] = { "actions.show_help", mode = "n" },
      ["<CR>"] = "actions.select",
      ["<C-c>"] = { "actions.close", mode = "n" },
      ["<C-l>"] = "actions.refresh",
      ["-"] = { "actions.parent", mode = "n" },
      ["_"] = { "actions.open_cwd", mode = "n" },
      ["`"] = { "actions.cd", mode = "n" },
      ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },
      ["gx"] = "actions.open_external",
      ["g."] = { "actions.toggle_hidden", mode = "n" },
    },
  },

  config = function(_, opts)
    require("oil").setup(opts)
    -- vim.keymap.set("n", "<space>pv", "<cmd>Oil<cr>")
  end,
  lazy = false,
}

