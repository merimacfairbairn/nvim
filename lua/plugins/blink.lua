return {
  'saghen/blink.cmp',
  dependencies = 'L3MON4D3/LuaSnip',
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {

      keymap = {
          preset = 'default',

          ['<C-h>'] = { 'show_signature', 'hide_signature', 'fallback' },
          ['K'] = { 'show', 'show_documentation', 'fallback' },
      },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },

    snippets = { preset = "luasnip" },

    completion = {
        accept = { auto_brackets = { enabled = false }, },
    },

    signature = { enabled = true },
  },

  opts_extend = { "sources.default" }
}
