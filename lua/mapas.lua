---@diagnostic disable: undefined-global
-- =============================================================================
-- FUNCIONES DE APOYO (Carga bajo demanda)
-- =============================================================================
local function docker_ui(cmd)
	require("toggleterm.terminal").Terminal
		:new({
			cmd = cmd,
			direction = "float",
			close_on_exit = false,
		})
		:toggle()
end

local function toggle_maximize()
	if vim.t.maximized then
		vim.cmd("wincmd =")
		vim.t.maximized = false
		print("📏 Ventanas restauradas")
	else
		vim.cmd("vertical resize | resize")
		vim.t.maximized = true
		print("🔍 Ventana maximizada")
	end
end

-- =============================================================================
-- NAVEGACIÓN Y ARCHIVOS
-- =============================================================================
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Guardar" })
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>", { desc = "Cerrar Buffer" })

-- Limpieza de Buffers
vim.keymap.set("n", "<leader>ba", function()
	local current = vim.api.nvim_get_current_buf()
	local count = 0
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if bufnr ~= current and vim.api.nvim_buf_is_loaded(bufnr) then
			if pcall(vim.api.nvim_buf_delete, bufnr, { force = false }) then
				count = count + 1
			end
		end
	end
	print("🧹 Buffers limpios: " .. count)
end, { desc = "Limpiar otros buffers" })

-- Copiar la ruta del archivo actual al portapapeles de Windows
vim.keymap.set("n", "<leader>cp", '<cmd>let @+ = expand("%:p")<cr>', { desc = "Copiar ruta completa" })

-- Abrir el navegador en el puerto de desarrollo local
vim.keymap.set(
	"n",
	"<leader>wb",
	"<cmd>silent execute '!start http://localhost:8080'<cr>",
	{ desc = "Abrir Localhost" }
)

-- Ventanas
vim.keymap.set("n", "<leader>zm", toggle_maximize, { desc = "Zen Maximize" })
vim.keymap.set("n", "<leader>=", "<C-w>=", { desc = "Igualar ventanas" })

-- =============================================================================
-- res.vim
-- =============================================================================
vim.keymap.set("n", "<leader>re", ":Res run<CR>", { desc = "Correr el cliente Res", silent = true })

-- =============================================================================
-- LSP Y PROGRAMACIÓN
-- =============================================================================
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Firma" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Implementación" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Ir a Definición" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Ver Referencias" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Info Hover" })

-- Snippets (Salto con J y K)
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	local ls = require("luasnip")
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end)
vim.keymap.set({ "i", "s" }, "<C-j>", function()
	local ls = require("luasnip")
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end)

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Renombrar" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Acciones" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Error flotante" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Siguiente Error" })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Error Anterior" })
vim.keymap.set("n", "<leader>v", function()
	vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "Toggle Texto Virtual" })

vim.keymap.set("n", "gf", [[/\vfunc|function|const.* \=\>|async\s+function<CR>]], { silent = true })

-- =============================================================================
-- DEBUGGING (DAP)
-- =============================================================================
local dap = require("dap")
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: Continuar" })
vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "DAP: Siguiente" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP: Entrar" })
vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "DAP: Reiniciar" })
-- =============================================================================
-- DEBUGGING GO AVANZADO (DAP)
-- =============================================================================
local dapui = pcall(require, "dapui") and require("dapui") or nil

-- Breakpoint condicional (solo detiene si se cumple una condición)
vim.keymap.set("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Condición de Breakpoint: "))
end, { desc = "DAP: Breakpoint Condicional" })

-- Inspeccionar la variable bajo el cursor
vim.keymap.set("n", "<leader>dh", function()
	require("dap.ui.widgets").hover()
end, { desc = "DAP: Inspeccionar Variable" })

-- Salir/Detener sesión de depuración activa
vim.keymap.set("n", "<leader>dq", function()
	dap.terminate()
	if dapui then
		dapui.close()
	end
	print("🛑 Depuración finalizada")
end, { desc = "DAP: Detener Debugger" })

-- Adjuntarse a un proceso remoto/Docker (Attach)
vim.keymap.set("n", "<leader>da", function()
	require("dap-go").debug_last_test()
end, { desc = "DAP: Repetir Último Test" })
-- =============================================================================
-- TESTING GO (Ejecución rápida)
-- =============================================================================
-- Ejecutar el test más cercano al cursor
vim.keymap.set("n", "<leader>gt", function()
	require("dap-go").debug_test()
end, { desc = "Debug Test (Cursor)" })

-- Ejecutar todos los tests del paquete actual en terminal flotante
vim.keymap.set("n", "<leader>gp", function()
	docker_ui("go test -v ./...")
end, { desc = "Go Test: Paquete Actual" })

-- Cobertura de tests (Generar y ver reporte de coverage)
vim.keymap.set("n", "<leader>gc", function()
	docker_ui("go test -coverprofile=coverage.out ./... && go tool cover -html=coverage.out")
end, { desc = "Go: Ver Cobertura (HTML)" })
-- =============================================================================
-- DOCKER Y SQL
-- =============================================================================
vim.keymap.set("n", "<leader>dps", function()
	docker_ui("docker ps")
end, { desc = "Docker Status" })
vim.keymap.set("n", "<leader>ddo", function()
	docker_ui("docker-compose down")
end, { desc = "Compose Down" })
vim.keymap.set("n", "<leader>dk", function()
	docker_ui("docker restart go_web_app")
end, { desc = "Restart App" })
vim.keymap.set("n", "<leader>drb", function()
	docker_ui("docker-compose down && docker-compose up --build -d")
end, { desc = "Docker Rebuild" })
vim.keymap.set("n", "<leader>gg", "<cmd>term lazygit<CR>", { desc = "Lazygit" })

-- SQL
vim.keymap.set({ "n", "v" }, "<leader>rq", "<cmd>DB<CR>", { desc = "Ejecutar SQL" })
vim.keymap.set("v", "<leader>bj", "<cmd>DB --format json<CR>", { desc = "SQL a JSON" })

-- =============================================================================
-- TERMINAL (Fix para Windows)
-- =============================================================================
vim.keymap.set("n", "<leader>te", "<cmd>split | terminal<CR>i", { desc = "Terminal" })
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Escape Terminal" })

-- =============================================================================
-- AUTOCOMANDOS (HBS y Otros)
-- =============================================================================
vim.api.nvim_create_autocmd("FileType", {
	pattern = "handlebars",
	callback = function()
		vim.keymap.set("n", "]]", [[/{{[#/].*}}<CR>]], { buffer = true, silent = true })
		vim.keymap.set("n", "[[", [[?{{[#/].*}}<CR>]], { buffer = true, silent = true })
	end,
})

-- =============================================================================
-- VENTANAS Y NAVEGACIÓN (Layout)
-- =============================================================================
vim.keymap.set("n", "<C-Left>", "<C-w>h")
vim.keymap.set("n", "<C-Down>", "<C-w>j")
vim.keymap.set("n", "<C-Up>", "<C-w>k")
vim.keymap.set("n", "<C-Right>", "<C-w>l")

vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +5<CR>")
vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize -5<CR>")
vim.keymap.set("n", "<M-Down>", "<cmd>resize +5<CR>")
vim.keymap.set("n", "<M-Up>", "<cmd>resize -5<CR>")

vim.keymap.set("n", "<leader>m", "<C-w>|<C-w>_", { desc = "Maximizar" })

-- =============================================================================
-- TELESCOPE & SNACKS PICKERS (Buscadores)
-- =============================================================================
local tb = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", tb.find_files, { desc = "Buscar Archivos" })
vim.keymap.set("n", "<leader>fg", tb.live_grep, { desc = "Buscar Texto" })
vim.keymap.set("n", "<leader>fb", tb.buffers, { desc = "Buscar en Buffers" })
vim.keymap.set("n", "<leader>fr", tb.oldfiles, { desc = "Recientes" })
vim.keymap.set("n", "<leader>h", "<cmd>Telescope yank_history<CR>", { desc = "Historial Copiado" })
vim.keymap.set("n", "<leader>td", "<cmd>TodoTelescope<CR>", { desc = "Buscar TODOs" })
vim.keymap.set("n", "<leader>fs", tb.lsp_document_symbols, { desc = "Símbolos del Archivo" })
vim.keymap.set("n", "<leader>fS", tb.lsp_dynamic_workspace_symbols, { desc = "Símbolos del Proyecto" })

vim.keymap.set("n", "<leader>fp", function()
	---@diagnostic disable: undefined-global
	Snacks.picker.projects()
end, { desc = "Proyectos Recientes" })

vim.keymap.set("n", "<leader>hd", function()
	Snacks.picker.help()
end, { desc = "Buscar en Ayuda/Doc" })

-- =============================================================================
-- ADMIN, CONFIG Y FORMATEO
-- =============================================================================
vim.keymap.set("n", "<leader>sv", "<cmd>source $MYVIMRC<CR>", { desc = "Recargar Config" })
vim.keymap.set("n", "<leader>cl", "<cmd>ClearNvim<CR>", { desc = "Limpiar Caché" })

-- CORRECCIÓN: Movido a <leader>fd (Format Document) para evitar conflicto de prefijos con Telescope (<leader>ff, <leader>fg...)
vim.keymap.set("n", "<leader>fd", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Formatear Buffer (Manual)" })

vim.keymap.set("n", "<leader>sf", function()
	require("conform").format({ bufnr = 0 })
	print("✨ SQL Formateado")
end, { desc = "Formatear archivo SQL" })

-- =============================================================================
-- CHEATSHEET
-- =============================================================================
vim.keymap.set("n", "<leader>.", function()
	local path = vim.fn.stdpath("config") .. "/CHEATSHEET.md"
	if vim.fn.filereadable(path) == 1 then
		vim.cmd("vsplit " .. path)
	end
end, { desc = "CheatSheet" })

vim.keymap.set("n", "<leader>ud", function()
	local path = vim.fn.stdpath("config") .. "/CHEATSHEET.md"
	os.remove(path)
	print("🗑️ Guía borrada. Reinicia Neovim para actualizarla.")
end, { desc = "Update Cheatsheet" })

-- Ventana flotante de ayuda
local function open_floating_help()
	local word = vim.fn.expand("<cword>")
	local buf = vim.api.nvim_create_buf(false, true)

	local opts = {
		relative = "editor",
		width = math.ceil(vim.o.columns * 0.7),
		height = math.ceil(vim.o.lines * 0.7),
		col = math.ceil(vim.o.columns * 0.15),
		row = math.ceil(vim.o.lines * 0.15),
		style = "minimal",
		border = "rounded",
	}

	vim.api.nvim_open_win(buf, true, opts)

	if vim.bo.filetype == "go" then
		vim.cmd("terminal go doc " .. word)
	elseif vim.bo.filetype == "sql" then
		print("¿Buscar '" .. word .. "' en Google? (s/n)")
		local char = vim.fn.getcharstr()
		if char == "s" then
			local url = "https://www.google.com/search?q=postgresql+sql+" .. word
			os.execute("start " .. url)
			vim.api.nvim_win_close(0, true)
		end
	else
		vim.cmd("help " .. word)
	end
end

vim.keymap.set("n", "<leader>he", open_floating_help, { desc = "Ayuda Flotante Pro" })
