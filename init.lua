-- Silenciar avisos de funciones obsoletas (Deprecations)
vim.g.deprecation_warnings = false
if vim.fn.has("win32") == 1 then
	vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
	-- ESTA LÍNEA ES EL ESCUDO:
	vim.opt.shellcmdflag =
		"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow"
	vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	vim.opt.shellquote = ""
	vim.opt.shellxquote = ""
end

-- 0. CODIFICACIÓN Y LEADER (Debe ir al puro principio)
vim.g.mapleader = ","
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.scriptencoding = "utf-8"
-- 1. SOLUCIÓN PARA TREESITTER (Runtimepath)
local data_path = vim.fn.stdpath("data"):gsub("\\", "/")
local site_path = data_path .. "/site"

if not vim.tbl_contains(vim.opt.rtp:get(), site_path) then
	vim.opt.rtp:append(site_path)
end

-- 2. PROVIDERS Y RUTA DE NODE
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.node_host_prog = vim.fn.expand("$APPDATA/npm/node_modules/neovim/bin/cli.js")

-- 3. CARGAR OPCIONES (Tus 2 espacios y diagnósticos)
local ok_opts, _ = pcall(require, "opciones")
if not ok_opts then
	print("⚠️ No se encontró lua/opciones.lua")
end

-- 4. INSTALACIÓN DE LAZY.NVIM
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- 5. CONFIGURACIÓN DE LAZY (Estructura Corregida)
require("lazy").setup({
	spec = {
		{ import = "plugins" }, -- Esto asume que tienes una carpeta lua/plugins/
	},
	ui = {
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
	rocks = { enabled = false },
	performance = {
		cache = { enabled = true },
	},
})

-- 6. CARGAR MAPAS Y AUTOCOMANDOS
pcall(require, "mapas")
pcall(require, "config.autocomandos")

-- Cheatsheet
pcall(function()
	require("config.generate_cheatsheet").setup()
end)

-- 7. ESTÉTICA FINAL
vim.cmd("highlight CursorLineNr guifg=#FAB387 gui=bold")
vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#F9E2AF", bg = "#1e1e2e" })

-- Auto-refresh Lualine
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if vim.bo.filetype ~= "alpha" then
			pcall(require("lualine").refresh)
		end
	end,
})
