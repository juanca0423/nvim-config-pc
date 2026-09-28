local function conf()
	local dap = require("dap")
	local dapui = require("dapui")

	-- Inicializar la interfaz gráfica de DAP
	dapui.setup()

	-- 1. CONFIGURACIÓN PARA NODE.JS / REACT
	local js_debug_path = vim.fn.stdpath("data")
		.. "/mason/packages/js-debug-adapter/js-debug/out/src/dapDebugServer.js"

	dap.adapters["pwa-node"] = {
		type = "executable",
		command = "node",
		args = { js_debug_path, "${port}" },
	}

	dap.adapters["pwa-chrome"] = {
		type = "executable",
		command = "node",
		args = { js_debug_path, "${port}" },
	}

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

	local react_config = {
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch Chrome against localhost",
			url = "http://localhost:5173",
			webRoot = "${workspaceFolder}",
			userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
		},
	}

	dap.configurations.typescriptreact = react_config
	dap.configurations.javascriptreact = react_config

	-- 2. CONFIGURACIÓN PARA GO (Windows)
	-- dap-go configura automáticamente los adapters y la conexión con Delve
	-- Cambia dlv.exe por dlv.cmd:

	require("dap-go").setup({
		delve = {
			path = vim.fn.stdpath("data") .. "\\mason\\bin\\dlv.cmd",
			initialize_timeout_sec = 20,
		},
		-- Agrega esta sección para indicarle a Delve que incluya todo el paquete al depurar tests:
		dap_configurations = {
			{
				type = "go",
				name = "Debug test (Package)",
				request = "launch",
				mode = "test",
				program = "./${relativeFileDirname}",
			},
		},
	})

	-- 3. ESTÉTICA DE BREAKPOINTS
	vim.fn.sign_define("DapBreakpoint", { text = "󰏃 ", texthl = "DiagnosticError" })
	vim.fn.sign_define("DapStopped", { text = "󰁕 ", texthl = "DiagnosticInfo" })

	-- 4. AUTOMATIZACIÓN DE LA UI
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end

	-- 5. FUNCIONES DE APOYO / EVALUACIÓN
	vim.keymap.set("n", "<leader>dh", function()
		require("dap.ui.widgets").hover()
	end, { desc = "Debug: Hover Variable" })

	vim.keymap.set({ "n", "v" }, "<leader>de", function()
		dapui.eval()
	end, { desc = "Debug: Evaluar Expresión Flotante" })

	vim.keymap.set("n", "<leader>dr", function()
		dap.repl.open()
	end, { desc = "Debug: Abrir REPL" })
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
				require("lazy").load({ plugins = { "nvim-dap" } })
				require("dap").continue()
			end,
			desc = "Debug: Start/Continue",
		},
		{
			"<leader>gt",
			function()
				require("lazy").load({ plugins = { "nvim-dap" } })
				require("dap-go").debug_test()
			end,
			desc = "Debug: Go Test (Current)",
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
		-- En la sección de keymaps de tu archivo de DAP
		{
			"<leader>dq",
			function()
				require("dap").terminate()
				require("dapui").close()
			end,
			desc = "Debug: Stop and Close UI",
		},
	},
	config = conf,
}
