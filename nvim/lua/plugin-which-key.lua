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
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find a file in current directory" },
			{
				"<leader>ft",
				function()
					require("telescope.builtin").find_files({
						cwd = vim.fn.expand("%:p:h"), -- current buffer directory
					})
				end,
				desc = "Find a file in current directory",
			},
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find in files" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },

			{ "<leader>fn", "<cmd>Telescope notify<cr>", desc = "View notifications" },
			{ "<leader>fT", "<cmd>Telescope treesitter<cr>", desc = "View Tree sitter" },
			-- -- Diagnostics

			{ "<leader>x", group = "Diagnostics" },
			{ "<leader>xd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to Definition", mode = "n" },
			{ "<leader>xr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename Symbol", mode = "n" },
			{
				"<leader>xx",
				function()
					require("telescope.builtin").diagnostics({ bufnr = 0 })
				end,
				desc = "Show diagnostics in current buffer",
				mode = "n",
			},
			{
				"<leader>xX",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "Show diagnostics",
				mode = "n",
			},
			{ "<leader>xc", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action", mode = { "n", "v" } },
			{ "<leader>xh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover Documentation", mode = "n" },
			{ "<leader>xi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Go to Implementation", mode = "n" },

			{ "<leader>xs", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", desc = "View document symbols", mode = "n" },
			{
				"<leader>xS",
				"<cmd>Telescope symbols<CR>",
				desc = "View workspace symbols",
				mode = "n",
			},
			{ "<leader>xe", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Show Diagnostics (float)", mode = "n" },
			{ "<leader>xR", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Go to References", mode = "n" },
			{ "<leader>xH", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Signature Help", mode = "n" },
			-- { "<leader>m", group = "Diagnostics" },
			-- { "<leader>mD", desc = "View declaration" },
			-- { "<leader>mR", desc = "Refrences" },
			-- { "<leader>m[", desc = "Prevoius diagnostic error" },
			-- { "<leader>m]", desc = "Next diagnostic error" },
			-- { "<leader>md", desc = "View definition" },
			-- { "<leader>me", desc = "Floating diagnostics win" },
			-- { "<leader>mh", desc = "Hover" },
			-- { "<leader>mi", desc = "Go to implementation" },
			-- { "<leader>mq", desc = "Diagnostic error list" },
			-- { "<leader>mr", desc = "Rename" },
			{ "<leader>xwa", desc = "Add workspace folder" },
			{ "<leader>xwl", desc = "List workspace folders" },
			{ "<leader>xwr", desc = "Remove workspace folder" },

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

			-- Lazy git
			{ "<leader>g", group = "Git" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "View Commits" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "View/Switch branch" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "View current status" },
			{
				"<leader>gl",
				"<cmd>LazyGit<cr>",
				desc = "Lazy Git",
				mode = { "n" },
			},
			-- { "<leader>x", group = "Troubles" },
			-- {
			-- 	"<leader>xx",
			-- 	"<cmd>Trouble diagnostics toggle<cr>",
			-- 	desc = "Diagnostics (Trouble)",
			-- },
			-- {
			-- 	"<leader>xX",
			-- 	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			-- 	desc = "Buffer Diagnostics (Trouble)",
			-- },
			-- {
			-- 	"<leader>xS",
			-- 	"<cmd>Trouble symbols toggle focus=false<cr>",
			-- 	desc = "Symbols (Trouble)",
			-- },
			-- {
			-- 	"<leader>xl",
			-- 	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			-- 	desc = "LSP Definitions / references / ... (Trouble)",
			-- },
			-- {
			-- 	"<leader>xL",
			-- 	"<cmd>Trouble loclist toggle<cr>",
			-- 	desc = "Location List (Trouble)",
			-- },
			-- {
			-- 	"<leader>xs",
			-- 	"<cmd>Trouble symbols<cr>",
			-- 	desc = "View symboles",
			-- },
			-- {
			-- 	"<leader>xQ",
			-- 	"<cmd>Trouble qflist toggle<cr>",
			-- 	desc = "Quickfix List (Trouble)",
			-- },
			-- Copilot
			{ "<leader>c", group = "Copilot" },
			{
				"<leader>cc",
				"<cmd>CopilotChatOutline<cr>",
				desc = "copilot prompt",
				mode = { "n", "v" },
			},

			{
				"<leader>ci",
				"<cmd>CopilotChatInline<cr>",
				desc = "copilot inline prompt",

				mode = { "n", "v" },
			},

			{
				"<leader>w",
				desc = "Window management",
				mode = { "n" },
			},

			{ "<leader>wh", "<C-w>h", desc = "Move to left window", mode = "n" },
			{ "<leader>wj", "<C-w>j", desc = "Move to below window", mode = "n" },
			{ "<leader>wk", "<C-w>k", desc = "Move to above window", mode = "n" },
			{ "<leader>wl", "<C-w>l", desc = "Move to right window", mode = "n" },
			{ "<leader>wv", "<C-w>v", desc = "Vertical split", mode = "n" },
			{ "<leader>ws", "<C-w>s", desc = "Horizontal split", mode = "n" },
			{ "<leader>wq", "<C-w>q", desc = "Quit window", mode = "n" },
			{ "<leader>ww", "<C-w>w", desc = "Next window", mode = "n" },
			{ "<leader>w=", "<C-w>=", desc = "Balance windows", mode = "n" },
			{ "<leader>w+", "<C-w>+", desc = "Increase window height", mode = "n" },
			{ "<leader>w-", "<C-w>-", desc = "Decrease window height", mode = "n" },
			{ "<leader>w_", "<C-w>_", desc = "Maximize window height", mode = "n" },
			{ "<leader>w|", "<C-w>|", desc = "Maximize window width", mode = "n" },
			{ "<leader>wH", "<C-w>H", desc = "Move window far left", mode = "n" },
			{ "<leader>wL", "<C-w>L", desc = "Move window far right", mode = "n" },
			{ "<leader>wr", "<C-w>r", desc = "Rotate windows", mode = "n" },
			{ "<leader>wR", "<C-w>R", desc = "Rotate windows opposite", mode = "n" },
			{ "<leader>wx", "<C-w>x", desc = "Swap windows", mode = "n" },
			{ "<leader>wT", "<C-w>T", desc = "Break out window into new tab", mode = "n" },
			{ "<leader>wo", "<C-w>o", desc = "Only keep current window", mode = "n" },
			{ "<leader>wQ", "<cmd>qa<cr>", desc = "Quit all", mode = "n" },
		})
	end,
}
