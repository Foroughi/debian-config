return {

	config = {
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.6",
			-- or                              , branch = '0.1.x',
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope-ui-select.nvim",
			},
		},
	},
	setup = function()
		local telescope = require("telescope")

		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local actions_layout = require("telescope.actions.layout")
		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-p>"] = require("telescope.actions.layout").toggle_preview,
					},
					n = {
						["<C-p>"] = require("telescope.actions.layout").toggle_preview,
					},
				},
				preview = {
					hide_on_startup = true, -- hide previewer when picker starts
				},
			},
			pickers = {
				live_grep = {
					initial_mode = "insert",
					file_ignore_patterns = { "node_modules", ".git", ".venv", ".nvim", "dist", ".cache" },
					additional_args = function(_)
						return { "--hidden" }
					end,
				},
				treesitter = {
					initial_mode = "insert",
				},
				find_files = {
					initial_mode = "insert",
					file_ignore_patterns = { "node_modules", ".git", ".venv", ".nvim", "dist", ".cache" },
					hidden = true,
				},
				file_browser = {
					initial_mode = "insert",
					file_ignore_patterns = { "node_modules", ".git", ".venv", ".nvim", "dist", ".cache" },
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						-- even more opts
					}),

					-- pseudo code / specification for writing custom displays, like the one
					-- for "codeactions"
					-- specific_opts = {
					--   [kind] = {
					--     make_indexed = function(items) -> indexed_items, width,
					--     make_displayer = function(widths) -> displayer
					--     make_display = function(displayer) -> function(e)
					--     make_ordinal = function(e) -> string
					--   },
					--   -- for example to disable the custom builtin "codeactions" display
					--      do the following
					--   codeactions = false,
					-- }
				},
			},
		})
		require("telescope").load_extension("notify")
		require("telescope").load_extension("ui-select")
		-- vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		-- vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		-- vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		-- vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
	end,
}
