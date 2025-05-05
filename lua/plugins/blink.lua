return {
  'saghen/blink.cmp',
  dependencies = 'L3MON4D3/LuaSnip',
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',

      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

      ['<C-h>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        lua = { 'lazydev', "lsp", "path", "snippets", "buffer" }
      },

      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        lsp = { score_offset = 3 },
        path = { score_offset = 2 },
        snippets = { score_offset = 1 },
        buffer = { score_offset = 0 },
      },
    },

    cmdline = {
      enabled = true,
      keymap = { preset = "inherit", },
      completion = {
        menu = { auto_show = true },
        ghost_text = {
          enabled = true,
        },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },

    snippets = { preset = "luasnip" },

    completion = {
      keyword = { range = 'full' },

      accept = { auto_brackets = { enabled = false }, },

      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },

    signature = { enabled = true },
  },

  opts_extend = { "sources.default" }
}
