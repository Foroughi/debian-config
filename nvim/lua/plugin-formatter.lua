return {

	config = {
		"mhartington/formatter.nvim",
		event = "VeryLazy",
	},
	setup = function()
		-- Utilities for creating configurations
		local util = require("formatter.util")

		-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
		require("formatter").setup({
			-- Enable or disable logging
			logging = true,
			-- Set the log level
			log_level = vim.log.levels.WARN,
			-- All formatter configurations are opt-in
			filetype = {
				-- Formatter configurations for filetype "lua" go here
				-- and will be executed in order
				lua = {
					-- "formatter.filetypes.lua" defines default configurations for the
					-- "lua" filetype
					require("formatter.filetypes.lua").stylua,

					-- You can also define your own configuration
					function()
						-- Supports conditional formatting
						if util.get_current_buffer_file_name() == "special.lua" then
							return nil
						end

						-- Full specification of configurations is down below and in Vim help
						-- files
						return {
							exe = "stylua",
							args = {
								"--search-parent-directories",
								"--stdin-filepath",
								util.escape_path(util.get_current_buffer_file_path()),
								"--",
								"-",
							},
							stdin = true,
						}
					end,
				},

				html = {
					--require("formatter.filetypes.html").prettier,

					function()
						return {
							exe = "prettier",
							args = {
								"--tab-width",
								"4",
								"--stdin-filepath",
								"--print-width",
								"500",
								"--prose-wrap",
								"never",
								util.escape_path(util.get_current_buffer_file_path()),
							},
							stdin = true,
							try_node_modules = true,
						}
					end,
				},
				go = {
					require("formatter.filetypes.go").goimports,
				},
				javascript = {
					-- require("formatter.filetypes.typescript").prettier,
					function()
						return {
							exe = "prettier",
							args = {
								"--tab-width",
								"4",
								"--stdin-filepath",
								"--print-width",
								"500",
								"--prose-wrap",
								"never",
								util.escape_path(util.get_current_buffer_file_path()),
							},
							stdin = true,
							try_node_modules = true,
						}
					end,
				},
				typescript = {
					-- require("formatter.filetypes.typescript").prettier,
					function()
						return {
							exe = "prettier",
							args = {
								"--tab-width",
								"4",
								"--stdin-filepath",
								"--print-width",
								"500",
								"--prose-wrap",
								"never",
								util.escape_path(util.get_current_buffer_file_path()),
							},
							stdin = true,
							try_node_modules = true,
						}
					end,
				},
				-- Use the special "*" filetype for defining formatter configurations on
				-- any filetype
				["*"] = {
					-- "formatter.filetypes.any" defines default configurations for any
					-- filetype
					require("formatter.filetypes.any").remove_trailing_whitespace,
					-- Remove trailing whitespace without 'sed'
					-- require("formatter.filetypes.any").substitute_trailing_whitespace,
				},
			},
		})
		--		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd
		--		augroup("__formatter__", { clear = true })
		autocmd("BufWritePost", {
			--	group = "__formatter__",
			command = ":FormatWrite",
		})
	end,
}
