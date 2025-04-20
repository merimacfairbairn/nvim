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
        on_attach = function(client, bufnr)
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

      rust_analyzer = {
      },
    },
  },

  config = function(_, opts)
    local lsp = require('lspconfig')
    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lsp[server].setup(config)
    end

    require("fidget").setup()

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
      ensure_installed = {
        "lua_ls",
        "clangd",
        "gopls",
        "ruff",
        "pyright",
      },
    })

    vim.diagnostic.config({
      update_in_insert = true,
      float = {
        foculable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end
}
