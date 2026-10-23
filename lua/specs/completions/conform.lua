return {
	"https://github.com/stevearc/conform.nvim",
	dependencies = {
		"https://github.com/mfussenegger/nvim-lint",
	},

	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			typescriptreact = { "prettier" },
			typescript = { "prettier" },
			markdown = { "prettier" },
			html = { "prettier" },
			svelte = { "prettier" },
			python = { "black" },
			nix = { "alejandra" },
			css = { "prettier" },
			rust = { "rustfmt" },
		},

		format_on_save = true,
		undojoin = true,
	},

	config = function(_, opts)
		require("conform").setup(opts)

		local lint = require("lint")

		-- Auto-run the linter only for the configured filetypes
		vim.api.nvim_create_autocmd("BufWritePost", {
			callback = function()
				local ft = vim.bo.filetype
				if lint.linters_by_ft[ft] then
					lint.try_lint()
				end
			end,
		})
	end,
}
