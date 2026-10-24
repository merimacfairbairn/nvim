return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "mocha",

			transparent_background = true,
			float = {
				transparent = true,
				solid = true,
			},

			show_end_of_buffer = true,
			term_colors = false,
			auto_integrations = true,
			integrations = {
				cmp = true,
				blink_cmp = {
					style = "bordered",
				},
			},
		},
		config = function(_, opts)
			vim.o.background = "dark"
			function ColorDefault(color)
				color = color or "catppuccin-mocha"
				vim.cmd.colorscheme(color)
			end

			require("catppuccin").setup(opts)

			ColorDefault()
		end,
	},
	{
		"tadaa/vimade",
		opts = {
			recipe = {
				"minimalist",
				animate = true,
			},

			fadelevel = 0.8,
		},
	},
}
