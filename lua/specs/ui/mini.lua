return {
	"nvim-mini/mini.animate",
	dependencies = {
		"nvim-mini/mini.pairs",
		config = true,
	},
	version = "*",
	config = function()
		local animate = require("mini.animate")
		require("mini.animate").setup({
			cursor = {
				enable = false,
			},
			scroll = {
				-- Animate for 200 milliseconds with linear easing
				timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
				-- Animate equally but with at most 120 steps instead of default 60
				subscroll = animate.gen_subscroll.equal({ max_output_steps = 60 }),
			},
		})
	end,
}
