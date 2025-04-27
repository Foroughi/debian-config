return {

	config = {
		"rcarriga/nvim-notify",
		event = "VeryLazy",
	},
	setup = function()
		require("notify").setup({
			stages = "fade_in_slide_out",
			timeout = 3000,
			max_width = function()
				return math.floor(vim.o.columns * 0.4) -- 40% of your window width
			end,
			max_height = function()
				return math.floor(vim.o.lines * 0.3) -- 30% of your window height
			end,
			--render = "wrapped-compact",
		})
		vim.notify = require("notify")
	end,
}
