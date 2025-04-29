return {
	config = {
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		-- ❌ remove opts = {},
	},
	setup = function()
		require("nvim-surround").setup({
			keymaps = {
				normal = "s",
				normal_cur = "ss",
				normal_line = "S",
				normal_cur_line = "SS",
				visual = "s",
				visual_line = "gS",
				delete = "ds",
				change = "cs",
				change_line = "cS",
			},
		})
	end,
}


