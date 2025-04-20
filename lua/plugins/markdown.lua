return {
  {
    "tadmccorkle/markdown.nvim",
    ft = "markdown", -- or 'event = "VeryLazy"'
    config = function()
      require("markdown").setup({
        -- Disable all keymaps by setting mappings field to 'false'.
        -- Selectively disable keymaps by setting corresponding field to 'false'.
        mappings = {
          inline_surround_toggle = "gs",       -- (string|boolean) toggle inline style
          inline_surround_toggle_line = "gss", -- (string|boolean) line-wise toggle inline style
          inline_surround_delete = "ds",       -- (string|boolean) delete emphasis surrounding cursor
          inline_surround_change = "cs",       -- (string|boolean) change emphasis surrounding cursor
          link_add = "gl",                     -- (string|boolean) add link
          link_follow = "gx",                  -- (string|boolean) follow link
          go_curr_heading = "]c",              -- (string|boolean) set cursor to current section heading
          go_parent_heading = "]p",            -- (string|boolean) set cursor to parent section heading
          go_next_heading = "]]",              -- (string|boolean) set cursor to next section heading
          go_prev_heading = "[[",              -- (string|boolean) set cursor to previous section heading
        },
        inline_surround = {
          -- For the emphasis, strong, strikethrough, and code fields:
          -- * 'key': used to specify an inline style in toggle, delete, and change operations
          -- * 'txt': text inserted when toggling or changing to the corresponding inline style
          emphasis = {
            key = "i",
            txt = "*",
          },
          strong = {
            key = "b",
            txt = "**",
          },
          strikethrough = {
            key = "s",
            txt = "~~",
          },
          code = {
            key = "c",
            txt = "`",
          },
        },
        link = {
          paste = {
            enable = true, -- whether to convert URLs to links on paste
          },
        },
        toc = {
          -- Comment text to flag headings/sections for omission in table of contents.
          omit_heading = "toc omit heading",
          omit_section = "toc omit section",
          -- Cycling list markers to use in table of contents.
          -- Use '.' and ')' for ordered lists.
          markers = { "-" },
        },
        -- Hook functions allow for overriding or extending default behaviour.
        -- Called with a table of options and a fallback function with default behaviour.
        -- Signature: fun(opts: table, fallback: fun())
        hooks = {
          -- Called when following links. Provided the following options:
          -- * 'dest' (string): the link destination
          -- * 'use_default_app' (boolean|nil): whether to open the destination with default application
          --   (refer to documentation on <Plug> mappings for explanation of when this option is used)
          follow_link = nil,
        },
        on_attach = function(bufnr)
          vim.keymap.set("n", "<space>toc", "<CMD>MDToc<CR>", { buffer = bufnr })
        end,
      })
    end
  },
  {
    "gaoDean/autolist.nvim",
    ft = {
      "markdown",
      "text",
    },
    config = function()
      -- Default patterns
      local list_patterns = {
        neorg_1 = "%-",
        neorg_2 = "%-%-",
        neorg_3 = "%-%-%-",
        neorg_4 = "%-%-%-%-",
        neorg_5 = "%-%-%-%-%-",
        unordered = "[-+*]", -- - + *
        digit = "%d+[.)]",   -- 1. 2. 3.
        ascii = "%a[.)]",    -- a) b) c)
        roman = "%u*[.)]",   -- I. II. III.
        latex_item = "\\item",
      }

      require("autolist").setup({
        lists = { -- configures list behaviours
          -- Each key in lists represents a filetype.
          -- The value is a table of all the list patterns that the filetype implements.
          -- See how to define your custom list below in the readme.
          -- You must put the file name for the filetype, not the file extension
          -- To get the "file name", it is just =:set filetype?= or =:se ft?=.
          pandoc = {
            list_patterns.unordered,
            list_patterns.digit,
            list_patterns.ascii, -- for example this specifies activate the ascii list
            list_patterns.roman, -- type for markdown files.
          },
        }
      })

      vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
      vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
      vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
      vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
      vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
      vim.keymap.set("n", "<Leader>r", "<cmd>AutolistRecalculate<cr>")

      -- cycle list types with dot-repeat
      vim.keymap.set("n", "<space>cn", require("autolist").cycle_next_dr, { expr = true })
      vim.keymap.set("n", "<space>cp", require("autolist").cycle_prev_dr, { expr = true })

      -- functions to recalculate list on edit
      vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
    end,
  },
  {
    'Kicamon/markdown-table-mode.nvim',
    cmd = "Mtm",
    config = function()
      require('markdown-table-mode').setup()
    end
  },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
}
