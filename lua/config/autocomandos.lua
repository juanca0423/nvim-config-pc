-- ==========================================================================
-- GRUPOS DE AUTOCOMANDOS (Evita duplicados al recargar)
-- ==========================================================================
local function augroup(name)
	return vim.api.nvim_create_augroup("gemini_custom_" .. name, { clear = true })
end

-- 1. LIMPIEZA DE BASURA SHADA (Específico para Windows)
-- Evita que se acumulen archivos temporales que ralentizan el inicio
if vim.fn.has("win32") == 1 then
	local shada_dir = vim.fn.expand("$LOCALAPPDATA/nvim-data/shada/")
	local tmp_files = vim.fn.glob(shada_dir .. "*.tmp.*", false, true)
	for _, file in ipairs(tmp_files) do
		vim.fn.delete(file)
	end
end

-- 2. DETECCIÓN AUTOMÁTICA DE RAÍZ DEL PROYECTO
-- Cambia el directorio de trabajo (CWD) al encontrar go.mod, .git, etc.
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("project_root"),
	callback = function()
		local root = vim.fs.find({ "go.mod", "package.json", ".git", "Makefile" }, {
			upward = true,
			path = vim.fn.expand("%:p:h"),
		})[1]
		if root then
			local root_dir = vim.fs.dirname(root)
			vim.fn.chdir(root_dir)
		end
	end,
})

-- 3. MEJORAS VISUALES Y DE EDICIÓN
-- Resaltar al copiar texto
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.hl.on_yank({ timeout = 200, visual = true })
	end,
})

-- Corrección para Handlebars (HBS) como HTML
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = augroup("hbs_fix"),
	pattern = "*.hbs",
	callback = function()
		vim.bo.filetype = "html"
		pcall(vim.treesitter.start)
	end,
})

-- 4. COMPORTAMIENTO DE INTERFAZ
-- Cerrar Neovim si el único buffer que queda es Nvim-Tree
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("nvim_tree_close"),
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
			vim.cmd("quit")
		end
	end,
})

-- Si cerramos el último buffer, abrir Alpha (Dashboard) automáticamente
vim.api.nvim_create_autocmd("BufDelete", {
	group = augroup("alpha_auto_open"),
	callback = function()
		vim.schedule(function()
			local bufs = vim.api.nvim_list_bufs()
			local loaded_bufs = 0
			for _, buf in ipairs(bufs) do
				if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
					loaded_bufs = loaded_bufs + 1
				end
			end
			if loaded_bufs == 0 then
				pcall(vim.cmd, "Alpha")
			end
		end)
	end,
})

-- 5. AJUSTES DE TERMINAL
-- Quitar números de línea y entrar en modo inserto automáticamente en la terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup("terminal_settings"),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.cmd("startinsert")
	end,
})

-- ==========================================================================
-- COMANDO PARA LIMPIAR NEVIM (Caché, Shada y Logs)
-- ==========================================================================
vim.api.nvim_create_user_command("ClearNvim", function()
	-- 1. Limpiar Shada (Historial de archivos, marcas, etc.)
	local shada_path = vim.fn.expand(vim.fn.stdpath("data") .. "/shada")
	local files = vim.fn.glob(shada_path .. "/*", false, true)
	for _, file in ipairs(files) do
		vim.fn.delete(file)
	end

	-- 2. Limpiar Logs de LSP (A veces crecen mucho)
	local lsp_log = vim.fn.expand(vim.fn.stdpath("cache") .. "/lsp.log")
	if vim.fn.filereadable(lsp_log) == 1 then
		vim.fn.delete(lsp_log)
	end

	-- 3. Limpiar caché de Telescope (si existe)
	pcall(function()
		require("telescope.builtin").resume() -- Esto a veces limpia estados internos
	end)

	print("✨ Neovim está limpio: Shada y Logs eliminados.")
end, { desc = "Limpia archivos temporales y logs de Neovim" })

-- ==========================================================================
-- COMANDOS DE UTILIDAD PARA DESARROLLO GO
-- ==========================================================================

-- Limpiar caché de Go (Compilación, Tests y Módulos)
vim.api.nvim_create_user_command("GoClean", function()
	print("🧹 Limpiando caché de Go...")
	vim.fn.system("go clean -cache -testcache -modcache")
	print("✨ Caché de Go eliminada correctamente.")
end, { desc = "Limpia toda la caché de Go" })

-- Formatear e Importar (Goimports alternativo)
vim.api.nvim_create_user_command("GoFix", function()
	vim.lsp.buf.format()
	vim.diagnostic.setqflist() -- Envía errores a la lista quickfix
	print("🛠️ Formateo aplicado y diagnósticos actualizados.")
end, { desc = "Formatea el buffer y revisa errores" })
