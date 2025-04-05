return {

	config = {
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	setup = function()

local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions
local builtin = require("telescope.builtin")
local action_state = require("telescope.actions.state")
		require("telescope").setup({
			extensions = {
				file_browser = {
					--theme = "ivy",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
					mappings = {
						["n"] = {
							["<CR>"] = function(prompt_bufnr)
								local selection = action_state.get_selected_entry()
								actions.close(prompt_bufnr)

								if selection and selection.path then
									local is_dir = vim.fn.isdirectory(selection.path) == 1
									local buffers = vim.api.nvim_list_bufs()
									local only_one_empty_buffer = #buffers == 1 and vim.fn.line2byte("$") == -1

									if is_dir then
										-- Open file browser in the selected directory
										require("telescope").extensions.file_browser.file_browser({
											cwd = selection.path,
										})
									else
										if only_one_empty_buffer then
											-- Reuse the existing empty buffer
											vim.cmd("edit " .. selection.path)
										else
											-- Open in a new tab if other buffers exist
											vim.cmd("tabnew " .. selection.path)
										end
									end
								end
							end,
							["<C-c>"] = fb_actions.create_from_prompt,
							["<C-r>"] = fb_actions.rename,
							["<C-x>"] = fb_actions.move,
							["<C-y>"] = fb_actions.copy,
							["<C-d>"] = fb_actions.remove,
							["<C-p>"] = fb_actions.goto_parent_dir,
							["<C-w>"] = fb_actions.goto_cwd,
							["<C-h>"] = fb_actions.toggle_hidden,
						},
						["i"] = {
							["<CR>"] = function(prompt_bufnr)
								local selection = action_state.get_selected_entry()
								actions.close(prompt_bufnr)

								if selection and selection.path then
									local is_dir = vim.fn.isdirectory(selection.path) == 1
									local buffers = vim.api.nvim_list_bufs()
									local only_one_empty_buffer = #buffers == 1 and vim.fn.line2byte("$") == -1

									if is_dir then
										-- Open file browser in the selected directory
										require("telescope").extensions.file_browser.file_browser({
											cwd = selection.path,
										})
									else
										if only_one_empty_buffer then
											-- Reuse the existing empty buffer
											vim.cmd("edit " .. selection.path)
										else
											-- Open in a new tab if other buffers exist
											vim.cmd("tabnew " .. selection.path)
										end
									end
								end
							end,
							["<C-c>"] = fb_actions.create_from_prompt,
							["<C-r>"] = fb_actions.rename,
							["<C-x>"] = fb_actions.move,
							["<C-y>"] = fb_actions.copy,
							["<C-d>"] = fb_actions.remove,
							["<C-p>"] = fb_actions.goto_parent_dir,
							["<C-w>"] = fb_actions.goto_cwd,
							["<C-h>"] = fb_actions.toggle_hidden,
						},
					},
				},
			},
		})
		-- To get telescope-file-browser loaded and working with telescope,
		-- you need to call load_extension, somewhere after setup function:
		require("telescope").load_extension("file_browser")
	end,
}
