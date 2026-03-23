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
vim.keymap.set("n", "<leader>aa", "<cmd>Alpha<cr>", { desc = "Inicio" })
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>", { desc = "Cerrar Buffer" }) -- Simplificado

-- Limpieza de Buffers (Tu favorita)
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

-- Ventanas
vim.keymap.set("n", "<leader>zm", toggle_maximize, { desc = "Zen Maximize" })
vim.keymap.set("n", "<leader>=", "<C-w>=", { desc = "Igualar ventanas" })

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
-- Diagnósticos
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Siguiente Error" })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Error Anterior" })
vim.keymap.set("n", "<leader>v", function()
	vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "Toggle Texto Virtual" })

-- Atajo universal para saltar a funciones (gf mejorado)
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
vim.keymap.set("n", "<leader>gt", function()
	require("dap-go").debug_test()
end, { desc = "Test Go" })

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
-- CONFIGURACIÓN DE DEPENDENCIAS (Lazy loading friendly)
-- =============================================================================
local function toggle_tree()
	local ok, api = pcall(require, "nvim-tree.api")
	if ok then
		api.tree.toggle({ focus = true, find_file = true })
	else
		print("NvimTree no cargado")
	end
end

-- =============================================================================
-- VENTANAS Y NAVEGACIÓN (Layout)
-- =============================================================================
-- Moverse (Ctrl + Flechas)
vim.keymap.set("n", "<C-Left>", "<C-w>h")
vim.keymap.set("n", "<C-Down>", "<C-w>j")
vim.keymap.set("n", "<C-Up>", "<C-w>k")
vim.keymap.set("n", "<C-Right>", "<C-w>l")

-- Redimensionar (Alt + Flechas)
vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +5<CR>")
vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize -5<CR>")
vim.keymap.set("n", "<M-Down>", "<cmd>resize +5<CR>")
vim.keymap.set("n", "<M-Up>", "<cmd>resize -5<CR>")

-- Control de Layout
vim.keymap.set("n", "<leader>m", "<C-w>|<C-w>_", { desc = "Maximizar" })
vim.keymap.set("n", "<leader>=", "<C-w>=", { desc = "Igualar ventanas" })
vim.keymap.set("n", "<C-t>", toggle_tree, { desc = "Explorador de Archivos" })

-- =============================================================================
-- TELESCOPE (Buscadores)
-- ============================================================================
local tb = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", tb.find_files, { desc = "Buscar Archivos" })
vim.keymap.set("n", "<leader>fg", tb.live_grep, { desc = "Buscar Texto" })
vim.keymap.set("n", "<leader>fb", tb.buffers, { desc = "Buscar en Buffers" })
vim.keymap.set("n", "<leader>fr", tb.oldfiles, { desc = "Recientes" })
vim.keymap.set("n", "<leader>h", "<cmd>Telescope yank_history<CR>", { desc = "Historial Copiado" })
vim.keymap.set("n", "<leader>td", "<cmd>TodoTelescope<CR>", { desc = "Buscar TODOs" })
vim.keymap.set("n", "<leader>fs", tb.lsp_document_symbols, { desc = "Símbolos del Archivo" })
vim.keymap.set("n", "<leader>fS", tb.lsp_dynamic_workspace_symbols, { desc = "Símbolos del Proyecto" })

-- =============================================================================
-- ADMIN Y CONFIG
-- =============================================================================
vim.keymap.set("n", "<leader>sv", "<cmd>source $MYVIMRC<CR>", { desc = "Recargar Config" })

vim.keymap.set("n", "<leader>cl", "<cmd>ClearNvim<CR>", { desc = "Limpiar Caché" })

vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Formatear Buffer (Manual)" })

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
