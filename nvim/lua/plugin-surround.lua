return {
	config = {
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		-- ❌ remove opts = {},
	},
	setup = function()
		require("nvim-surround").setup({})
	end,
}
