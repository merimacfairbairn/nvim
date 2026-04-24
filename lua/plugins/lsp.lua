return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "j-hui/fidget.nvim",
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },

  event = { "BufReadPre", "BufNewFile" },

  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      },

      ruff = {
        settings = {
          lineLength = 88,
        },
      },

      pyright = {
        handlers = {
          ["textDocument/publishDiagnostics"] = function() end,
        },
        settings = {
          pyright = {
            autoImportCompletion = true,
          },
          python = {
            analysis = {
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic",
              reportMissingImports = false,
              reportUnusedImports = false,
              reportUnusedVariable = false,
            },
          },
        },
      },

      html = {
        filetypes = { "html", "htmldjango" },
        init_options = {
          configurationSection = { "html", "css", "javascript" },
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
        },
      },

      harper_ls = {
        settings = {
          ["harper-ls"] = {
            markdown = {
              IgnoreLinkTitle = true,
            },
            linters = {
              LongSentences = false,
            },
            dialect = "British",
          },
        },
      },
    },
  },

  config = function(_, opts)
    local lsp = vim.lsp

    for server, config in pairs(opts.servers) do
      local capabilities = vim.deepcopy(config.capabilities or {})

      local blink_caps = require("blink.cmp").get_lsp_capabilities()
      config.capabilities = vim.tbl_deep_extend("force", capabilities, blink_caps)

      lsp.config(server, {
        cmd = config.cmd,
        root_dir = config.root_dir,
        settings = config.settings,
        capabilities = config.capabilities,
        filetypes = config.filetypes,
        handlers = config.handlers,
      })

      lsp.enable(server)
    end

    require("fidget").setup({
      notification = {
        override_vim_notify = true,
      },
    })

    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      automatic_enable = false,
      ensure_installed = {
        "lua_ls",
        "clangd",
        "gopls",
        "ruff",
        "pyright",
        "marksman",
        "harper_ls",
      },
    })

    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
      },
      severity_sort = true,
    })
  end,
}
