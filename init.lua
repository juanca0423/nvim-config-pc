-- vim.g.netrw_liststyle = 3
-- 0. CONFIGURACIÓN INICIAL
vim.g.mapleader = ","

-- SOLUCIÓN PARA TREESITTER (Runtimepath) - Versión Robusta para Windows
local parser_install_dir = vim.fn.stdpath("data") .. "/site"
-- Normalizamos la ruta: cambiamos \ por / y quitamos duplicadas
parser_install_dir = parser_install_dir:gsub("\\", "/")

-- Agregamos al runtimepath de forma explícita
vim.opt.runtimepath:prepend(parser_install_dir)

-- Verificación manual para tu tranquilidad (puedes borrar este print después)
-- print("RTP Actualizado: " .. parser_install_dir)

if vim.fn.isdirectory(parser_install_dir) == 0 then
	vim.fn.mkdir(parser_install_dir, "p")
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Indicarle a Neovim dónde está Node (Evita el warning de checkhealth)
vim.g.node_host_prog = vim.fn.expand("$APPDATA/npm/node_modules/neovim/bin/cli.js")

-- 1. OPCIONES BÁSICAS (Cargar antes que nada)
require("opciones")

-- 2. SHELL Y PROVIDERS (Windows)
if vim.fn.has("win32") == 1 then
	vim.opt.shell = "pwsh.exe"
	vim.opt.shellcmdflag =
		"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
	vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s"
	vim.opt.shellquote = ""
	vim.opt.shellxquote = ""
	-- Desactivar python/ruby si no los usas para ganar velocidad
	vim.g.python3_host_prog = nil
	vim.g.python3_host_prog = vim.fn.expand("$LOCALAPPDATA/Python/bin/python3.EXE")
	vim.g.loaded_ruby_provider = 0
	vim.g.loaded_perl_provider = 0
end
-- 3. GESTIÓN DE PLUGINS (Lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	rocks = { enabled = false },
	performance = { cache = { enabled = true } },
})

-- 4. CARGA DE CONFIGURACIONES RESTANTES
require("mapas")
require("config.autocomandos")
require("config.generate_cheatsheet").setup() -- Llamamos al generador

-- 5. CORRECCIONES ESTÉTICAS FINALES
vim.cmd("highlight CursorLineNr guifg=#FAB387 gui=bold")
-- 3. ESTÉTICA RÁPIDA (Solo highlights)
-- Ajuste estético para Treesitter Context
vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#1e1e2e" }) -- Fondo Mocha
vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#F9E2AF", bg = "#1e1e2e" })

-- Limpiador de buffers vacíos al inicio (Para que Alpha quede solo)
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			vim.schedule(function()
				local bufs = vim.api.nvim_list_bufs()
				for _, buf in ipairs(bufs) do
					if vim.bo[buf].filetype ~= "alpha" and vim.api.nvim_buf_get_name(buf) == "" then
						pcall(vim.api.nvim_buf_delete, buf, { force = true })
					end
				end
			end)
		end
	end,
})

-- Números amarillos
