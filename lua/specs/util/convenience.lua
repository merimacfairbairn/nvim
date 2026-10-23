return {
  "okuuva/auto-save.nvim",
  dependencies = {
    "vladdoster/remember.nvim",
  },

  config = function()
    require("auto-save").setup({
    enabled = true,
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
      defer_save = { "InsertLeave" },           -- save after debounce
      cancel_deferred_save = { "InsertEnter" }, -- cancel pending save
    },

    debounce_delay = 1000,
    noautocmd = true,
  })

    require("remember").setup({})
  end,
}
