return {
  "hinell/lsp-timeout.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  init = function()
    vim.g.lspTimeoutConfig = {
      stopTimeout  = 1000 * 60 * 2, -- ms, time-out before stopping all LSPs
      startTimeout = 1000 * 10,     -- ms, time-out before restart
      silent       = false          -- true to suppress notifications
    }
  end
}
