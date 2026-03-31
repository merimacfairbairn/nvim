return {
    "benlubas/molten-nvim",  -- "dubrayn/molten-nvim", -- fork of this  - REPL
    version = "^1.0.0",
    dependencies = {
      "3rd/image.nvim",
      {
        'GCBallesteros/jupytext.nvim',
        opts = {
          style = "markdown",
          output_extension = "md",
          force_ft = "markdown",
        },
        config = function(_, opts)
          local jupytext = require("jupytext")
          jupytext.setup(opts)
        end
      },
      {
        "quarto-dev/quarto-nvim",
        dependencies = {
          "jmbuhr/otter.nvim",
          "nvim-treesitter/nvim-treesitter",
          {
            "nvimtools/hydra.nvim",
            config = function()
              local function keys(str)
                return function()
                  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "m", true)
                end
              end

              local hydra = require("hydra")
              hydra({
                  name = "QuartoNavigator",
                  hint = table.concat({
                    "_j_/_k_: move down/up",
                    "_J_/_K_: swap next/previous cell",
                    "_r_: run cell",
                    "_d_: delete cell",
                    "_o_: enter output mode",
                    "_l_: run line  _R_: run above",
                    "_<C-r>_: restart kernel",
                    "^^     _<esc>_/_q_: exit",
                  }, "\n"),
                  config = {
                      color = "pink",
                      invoke_on_body = true,
                      float_ops = {
                        style = "minimal"
                      },
                  },
                  mode = { "n" },
                  body = "<leader>j", -- this is the key that triggers the hydra
                  heads = {
                      { "j", keys("]bzz") },
                      { "k", keys("[bzz") },
                      { "J", keys(",scj") },
                      { "K", keys(",sck") },
                      { "d", ":MoltenDelete<CR>" },
                      { "o", ":noautocmd MoltenEnterOutput<CR>" },
                      { "h", ":MoltenHideOutput<CR>" },
                      { "r", ":QuartoSend<CR>" },
                      { "l", ":QuartoSendLine<CR>" },
                      { "R", ":QuartoSendAbove<CR>" },
                      { "<C-r>", ":MoltenRestart<CR>" },
                      { "<esc>", nil, { exit = true } },
                      { "q", nil, { exit = true } },
                  },
              })
            end,
          },
        },
        config = function()
          require("quarto").setup({
            codeRunner = {
              enabled = true,
              default_method = "molten",
            },
          })

          local runner = require("quarto.runner")
          local ts_move = require("nvim-treesitter.textobjects.move")

          vim.keymap.set("n", "<leader>rc", runner.run_cell,  { desc = "run cell", silent = true })
          vim.keymap.set("n", "<leader>ra", runner.run_above, { desc = "run cell and above", silent = true })
          vim.keymap.set("n", "<leader>rA", runner.run_all,   { desc = "run all cells", silent = true })
          vim.keymap.set("n", "<leader>rl", runner.run_line,  { desc = "run line", silent = true })
          -- vim.keymap.set("v", "<leader>r",  runner.run_range, { desc = "run visual range", silent = true })
          vim.keymap.set("n", "<leader>rn", function()
            runner.run_cell()
            ts_move.goto_next_start("@code_cell.inner", false)
            vim.cmd.normal("zz")
          end)

          vim.keymap.set("n", "]b", function()
            ts_move.goto_next_start("@code_cell.inner", false)
          end, { desc = "next code block", silent = true })
          vim.keymap.set("n", "[b", function()
            ts_move.goto_previous_start("@code_cell.inner", false)
          end, { desc = "previous code block", silent = true })

          vim.keymap.set("n", "<leader>RA", function()
            runner.run_all(true)
          end, { desc = "run all cells of all languages", silent = true })

          require("nvim-treesitter.configs").setup({
            -- ... other ts config
            textobjects = {
                move = {
                    enable = true,
                    set_jumps = false, -- you can change this if you want.
                    goto_next_start = {
                        --- ... other keymaps
                        ["]b"] = { query = "@code_cell.inner", desc = "next code block" },
                    },
                    goto_previous_start = {
                        --- ... other keymaps
                        ["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
                    },
                },
                select = {
                    enable = true,
                    lookahead = true, -- you can change this if you want
                    keymaps = {
                        --- ... other keymaps
                        ["ic"] = { query = "@code_cell.inner", desc = "in block" },
                        ["ac"] = { query = "@code_cell.outer", desc = "around block" },
                    },
                },
                swap = { -- Swap only works with code blocks that are under the same
                         -- markdown header
                    enable = true,
                    swap_next = {
                        --- ... other keymap
                        ["<leader>scj"] = "@code_cell.outer",
                    },
                    swap_previous = {
                        --- ... other keymap
                        ["<leader>sck"] = "@code_cell.outer",
                    },
                },
              }
            })
        end
      },
    },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_image_location = "virt"
      vim.g.molten_auto_init_behavior = "init"
      vim.g.molten_enter_output_behavior = "open_and_enter"
      vim.g.molten_auto_image_popup = false
      vim.g.molten_auto_open_output = false
      vim.g.molten_output_virt_lines = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_virt_text_max_lines = 10
      vim.g.molten_cover_empty_lines = true
      vim.g.molten_copy_output = true
      vim.g.molten_output_show_exec_time = true
      vim.g.molten_wrap_output = true

      -- don't change the mappings (unless it's related to your bug)
      vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>")
      vim.keymap.set("n", "<leader>e", ":MoltenEvaluateOperator<CR>")
      vim.keymap.set("n", "<leader>rr", ":MoltenReevaluateCell<CR>")
      vim.keymap.set("v", "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>gv")
      vim.keymap.set("n", "<leader>os", ":noautocmd MoltenEnterOutput<CR>")
      vim.keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>")
      vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>")
    end,
}
