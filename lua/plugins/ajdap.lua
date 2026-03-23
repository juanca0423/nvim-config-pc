local function conf()
	local dap = require("dap")
	local dapui = require("dapui")

	dapui.setup()

	-- 1. CONFIGURACIÓN PARA NODE.JS (Windows - Adaptado para lanzar procesos)
	dap.adapters["pwa-node"] = {
		type = "executable",
		command = "node",
		args = {
			vim.fn.expand("$LOCALAPPDATA/nvim-data/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"),
			"${port}",
		},
	}

	-- Configuración de lanzamiento para JS/TS
	dap.configurations.javascript = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
	}
	dap.configurations.typescript = dap.configurations.javascript

	-- 2. CONFIGURACIÓN PARA GO (Windows)
	require("dap-go").setup({
		delve = {
			path = vim.fn.stdpath("data") .. "/mason/bin/dlv.exe",
			initialize_timeout_sec = 20,
		},
	})

	-- 3. ESTÉTICA DE BREAKPOINTS
	vim.fn.sign_define("DapBreakpoint", { text = "󰏃 ", texthl = "DiagnosticError" })
	vim.fn.sign_define("DapStopped", { text = "󰁕 ", texthl = "DiagnosticInfo" })

	-- 4. AUTOMATIZACIÓN DE LA UI
	-- Usamos listeners para que la UI reaccione al inicio del debug
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		-- Opcional: dapui.close() si quieres que se cierre solo
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		-- Opcional: dapui.close()
	end

	-- 5. CONFIGURACIÓN DEL REPL Y HOVER
	vim.keymap.set("n", "<leader>dh", function()
		require("dap.ui.widgets").hover()
	end, { desc = "Debug: Hover Variable" })
	vim.keymap.set("n", "<leader>de", function()
		require("dap").repl.open()
	end, { desc = "Debug: Open REPL" })
end

return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"leoluz/nvim-dap-go",
		"nvim-neotest/nvim-nio",
	},
	keys = {
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Start/Continue",
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step Over",
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step Into",
		},
		{
			"<F12>",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step Out",
		},
		{
			"<leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle Breakpoint",
		},
		{
			"<leader>B",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Debug: Set Breakpoint",
		},
		{
			"<leader>du",
			function()
				require("dapui").toggle()
			end,
			desc = "Debug: Toggle UI",
		},
	},
	config = conf,
}
