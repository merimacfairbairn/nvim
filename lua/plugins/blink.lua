return {
  'saghen/blink.cmp',
  dependencies = {
    'L3MON4D3/LuaSnip',
    "moyiz/blink-emoji.nvim",
    "Kaiser-Yang/blink-cmp-dictionary",
  },
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
      default = { "lsp", "path", "snippets", "buffer", "emoji", "dictionary" },
      per_filetype = {
        lua = { "lazydev", inherit_defaults = true },
      },

      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 95,
        },

        lsp = {
          score_offset = 90,
          fallbacks = nil
        },
        path = { score_offset = 40 },

        snippets = {
          name = "snippets",
          enabled = true,
          max_items = 15,
          min_keyword_length = 2,
          module = "blink.cmp.sources.snippets",
          score_offset = 85,
        },

        buffer = { score_offset = 0 },
        cmdline = {
          min_keyword_length = function(ctx)
            -- when typing a command, only show when the keyword is 3 characters or longer
            if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 3 end
            return 0
          end
        },

        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 50,
          opts = { insert = true },
        },

        dictionary = {
          module = "blink-cmp-dictionary",
          name = "Dict",
          score_offset = 5,
          enabled = true,
          max_items = 8,
          min_keyword_length = 3,
          opts = {
            dictionary_files = {
              vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"),
              "/usr/share/dict/british-english",
            }
          },
        },
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

  opts_extend = { "sources.default" },
}
