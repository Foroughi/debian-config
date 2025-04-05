return {

	config = {
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 0
		end,
		config = true,
		opts = {
			preset = "helix",
			win = {
				--margin = { 0, 1, 1, 0.75 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
				padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
				zindex = 1000, -- positive value to position WhichKey above other floating windows.
				bo = {
					-- bg = "#ffffff",
				},
				wo = {
					winblend = 20,
				},
			},
			layout = {
				height = { min = 4, max = 65 }, -- min and max height of the columns
				width = { min = 100, max = 100 }, -- min and max width of the columns
				spacing = 0, -- spacing between columns
				align = "center", -- align columns left, center or right
			},
			filter = function(mapping)
				return true
			end,
		},
	},
	setup = function()
		local wk = require("which-key")

		wk.add({

            -- Telescope
			{ "<leader>f", group = "Telescope" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List of opened windows" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "View LSP diagnostics" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find a file in current directory" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find in files" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
			{
				"<leader>ft",
				"<cmd>Telescope file_browser path=%:p:help |select_buffer=true<cr>|",
				desc = "Show file tree",
			},

            -- Diagnostics
			{ "<leader>m", group = "Diagnostics" },
			{ "<leader>mD", desc = "View declaration" },
			{ "<leader>mR", desc = "Refrences" },
			{ "<leader>m[", desc = "Prevoius diagnostic error" },
			{ "<leader>m]", desc = "Next diagnostic error" },
			{ "<leader>md", desc = "View definition" },
			{ "<leader>me", desc = "Floating diagnostics win" },
			{ "<leader>mh", desc = "Hover" },
			{ "<leader>mi", desc = "Go to implementation" },
			{ "<leader>mq", desc = "Diagnostic error list" },
			{ "<leader>mr", desc = "Rename" },
			{ "<leader>mwa", desc = "Add workspace folder" },
			{ "<leader>mwl", desc = "List workspace folders" },
			{ "<leader>mwr", desc = "Remove workspace folder" },

            -- Tab navigations
			{ "<leader>t", group = "Tab navigation" },
			{ "<leader>tQ", "<cmd>quitall<cr>", desc = "Close all" },
			{ "<leader>th", "<cmd>tabprev<cr>", desc = "Move to previouse tab" },
			{ "<leader>tl", "<cmd>tabnext<cr>", desc = "Move to next tab" },
			{ "<leader>tn", "<cmd>tabnew<cr>", desc = "New tab" },
			{ "<leader>tq", "<cmd>q<cr>", desc = "Close current tab" },

            -- Clipboard
			{ "<leader>p", desc = "Paste from system clipboard" },
			{ "<leader>y", desc = "Copy to system clipboard" },

            -- Debug
			{ "<leader>d", group = "Debug mode" },
			{ "<leader>dc", desc = "Start/Continue" },
			{ "<leader>dt", desc = "Terminate" },
			{ "<leader>dh", desc = "Hover to get more info" },
			{ "<leader>db", desc = "Toggle breakpoint" },
			{ "<leader>de", desc = "Check value" },
			{ "<leader>ds", desc = "Watches" },

			{ "<leader>M", "<cmd>messages<cr>", desc = "View lastest messages" },
			{ "<leader>T", "<cmd>Telescope treesitter<cr>", desc = "View Tree sitter" },

            -- Lazy git
			{ "<leader>g", group = "Git" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "View Commits" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "View/Switch branch" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "View current status" },
			{
				"<leader>gl",
				"<cmd>LazyGit<cr>",
				desc = "Lazy Git",
                mode = {"n"}
			},
			{ "<leader>x", group = "Troubles" },
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>xS",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xs",
				"<cmd>Trouble symbols<cr>",
				desc = "View symboles",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
            -- Copilot
			{ "<leader>c", group = "Copilot" },
			{
				"<leader>cc",
				"<cmd>CopilotChatToggle<cr>",
				desc = "Copilot Prompt",
			},
		})
	end,
}
