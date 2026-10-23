return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
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

      nixd = {
        cmd = { "nixd" },
        settings = {
          nixd = {
            nixpkgs = {
              expr = "import <nixpkgs> { }",
            },
            formatting = {
              command = { "alejandra" },
            },
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

    -- Only show diagnostics close to the cursor
    vim.diagnostic.config({
      virtual_text = {
        spacing = 4,
        prefix = function(diagnostic)
          local icons = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = "󰉀 ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵 ",
          }
          return icons[diagnostic.severity] or ""
        end,
      },
      signs = false,
      underline = true,
      update_in_insert = false,

      severity_sort = true,
    })
  end,
}
