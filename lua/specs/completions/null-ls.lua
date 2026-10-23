return {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
  },

  config = function()
    require("mason-null-ls").setup({
      ensure_installed = { "isort", "black", "djlint", "prettier", "markdownlint" },
      automatic_installation = true,
    })

    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.prettier.with({
          extra_args = {
            "--print-width", "80",
            "--prose-wrap", "always",
          },
        }),
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.formatting.djlint.with({
          filetypes = { "htmldjango" },
          extra_args = { "--indent-size", "2" },
        }),
      },
    })
  end,
}
