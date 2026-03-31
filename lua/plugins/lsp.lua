return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "j-hui/fidget.nvim",
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },

  event = { "BufNewFile", "BufReadPre" },
  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          },
        },
      },

      ruff = {
        init_options = {
          settings = {
            lineLength = 88,
          }
        }
      },

      pyright = {
        on_attach = function(client, _)
          if client.name == "pyright" then
            client.handlers["textDocument/publishDiagnostics"] = function() end -- no diagnostics from pyright
          end
        end,
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
            }
          },
        }
      },

      html = {
        filetypes = { "html", "htmldjango" }, -- Ensure it works with Django templates
        init_options = {
          configurationSection = { "html", "css", "javascript" },
          embeddedLanguages = {
            css = true,
            javascript = true
          }
        }
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
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)

      -- Define the LSP configuration using vim.lsp.config
      lsp.config(server, {
        cmd = config.cmd,
        root_dir = config.root_dir,
        settings = config.settings,
        capabilities = config.capabilities,
        filetypes = config.filetypes,
      })

      -- Enable the LSP server
      lsp.enable(server)
    end

    require("fidget").setup({
      notifications = {
        override_vim_notify = true,
      },
    })

    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    require("mason-lspconfig").setup({
      automatic_enable = true,
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
      virtual_text     = true,
      signs            = true,
      underline        = true,
      update_in_insert = true,
      float            = {
        focusable = false,
        style     = "minimal",
        border    = "rounded",
        source    = "if_many",
        header    = "",
        prefix    = "",
      },
      severity_sort    = true,
    })
  end
}
