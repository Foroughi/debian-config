return {

	config = {
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"mxsdev/nvim-dap-vscode-js",
			-- build debugger from source
			{
				"microsoft/vscode-js-debug",
				version = "1.x",
				build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
			},
		},
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
			},
			{
				"<leader>dh",
				function()
					require("dap").hover()
				end,
			},
			{
				"<leader>de",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.expression)
					-- local dapui = require("dapui.elements")
					-- dapui.w
				end,
			},
			{
				"<leader>ds",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.scopes)
				end,
			},
			{
				"<F9>",
				function()
					require("dap").step_over()
				end,
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
			},
			{
				"<F10>",
				function()
					require("dap").step_out()
				end,
			},
		},
		config = function() end,
	},
	setup = function()
		local lazy_avail, lazy_config = pcall(require, "lazy.core.config")

		require("dap-vscode-js").setup({
			debugger_path = os.getenv("HOME") .. "/.config/nvim/plugins/vscode-js-debug", -- Path to vscode-js-debug installation.
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
			log_console_level = vim.log.levels.ERROR, -- Logging level for output to console. Set to false to disable console output.
		})
		for _, language in ipairs({ "typescript", "javascript" }) do
			require("dap").configurations[language] = {
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch",
					runtimeExecutable = "npm",
					runtimeArgs = {
						"run",
						"dev",
					},
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
				},
			}
		end

		require("dapui").setup()
		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open({ reset = true })
		end
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
	end,
}
