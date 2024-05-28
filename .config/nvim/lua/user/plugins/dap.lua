return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local dapgo = require("dap-go")
			require("dapui").setup()
			require("nvim-dap-virtual-text").setup()
			dapgo.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<leader>dd", function()
				dapui.toggle()
			end)
			vim.keymap.set("n", "<leader>de", function()
				dapui.eval()
			end)
			vim.keymap.set("n", "<leader>dt", function()
				dapgo.debug_test()
			end)
			vim.keymap.set("n", "<F1>", function()
				dap.toggle_breakpoint()
			end)
			vim.keymap.set("n", "<F2>", function()
				dap.step_over()
			end)
			vim.keymap.set("n", "<F3>", function()
				dap.step_into()
			end)
			vim.keymap.set("n", "<F4>", function()
				dap.step_out()
			end)
			vim.keymap.set("n", "<F5>", function()
				dap.continue()
			end)

			vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, bg = "#8A4E4E" })
			vim.api.nvim_set_hl(0, "DapBreakpointSymbol", { ctermbg = 0, fg = "#993939" })
			vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, bg = "#61afef" })
			vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, bg = "#628561" })
			vim.api.nvim_set_hl(0, "DapStoppedSymbol", { ctermbg = 0, fg = "#98c379" })

			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "", texthl = "DapBreakpointSymbol", linehl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "", texthl = "DapBreakpointSymbol", linehl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "", texthl = "DapBreakpointSymbol", linehl = "DapBreakpoint" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint" })
			vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStoppedSymbol", linehl = "DapStopped" })
		end,
	},
}
