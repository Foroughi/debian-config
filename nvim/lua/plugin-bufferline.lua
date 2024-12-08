return {

	config = {
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	setup = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "tabs", -- set to "tabs" to only show tabpages instead
				style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
				themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
				numbers = "none",
				indicator = {
					style = "icon",
				},
				buffer_close_icon = "󰅖",
				modified_icon = "● ",
				left_trunc_marker = " ",
				right_trunc_marker = " ",
				--- name_formatter can be used to change the buffer's label in the bufferline.
				--- Please note some names can/will break the
				--- bufferline so use this at your discretion knowing that it has
				--- some limitations that will *NOT* be fixed.
				max_name_length = 18,
				max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
				truncate_names = true, -- whether or not tab names should be truncated
				tab_size = 18,
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false, -- only applies to coc
				diagnostics_update_on_event = true, -- use nvim's diagnostic handler
				-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "left",
						separator = true,
					},
				},
				color_icons = true, -- whether or not to add the filetype icon highlights
				get_element_icon = function(element)
					-- element consists of {filetype: string, path: string, extension: string, directory: string}
					-- This can be used to change how bufferline fetches the icon
					-- for an element e.g. a buffer or a tab.
					-- e.g.
					local icon, hl =
						require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
					return icon, hl
					-- or
				end,
				show_buffer_icons = true, -- disable filetype icons for buffers
				show_buffer_close_icons = false,
				show_close_icon = false,
				show_tab_indicators = false,
				show_duplicate_prefix = false, -- whether to show duplicate buffer prefix
				duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
				persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
				move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
				-- can also be a table containing 2 custom separators
				-- [focused and unfocused]. eg: { '|', '|' }
				-- separator_style = "",
				enforce_regular_tabs = false,
				always_show_bufferline = true,
				auto_toggle_bufferline = true,
				sort_by = "id",
				separator_style = "slant",
				pick = {
					alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
				},
			},
		})
	end,
}
