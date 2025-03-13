return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    event = { "BufNewFile", "BufReadPre" },

    config = function()
        local lsp = require("lspconfig")
        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

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

        require("mason-lspconfig").setup_handlers({
            function(server_name)
                lsp[server_name].setup({
                    capabilities = capabilities
                })
            end,
            ["lua_ls"] = function()
                lsp.lua_ls.setup({
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }
                            }
                        }
                    }
                })
            end,
            ["ruff"] = function()
                lsp.ruff.setup({
                    init_options = {
                        settings = {
                            lineLength = 88,
                        },
                    }
                })
            end,
            ["pyright"] = function()
                lsp.pyright.setup({
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
                })
            end
        })

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
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
