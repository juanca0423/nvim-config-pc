-- Silenciar avisos de funciones obsoletas (Deprecations)
vim.g.deprecation_warnings = false
-- Deshabilitar proveedores que no usamos (adiós avisos de Perl y Ruby)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
if vim.fn.has("win32") == 1 then
	vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
	-- ESTA LÍNEA ES EL ESCUDO:
	vim.opt.shellcmdflag =
		"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow"
	vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; if($?) { exit $LASTEXITCODE }"
	vim.opt.shellquote = ""
	vim.opt.shellxquote = ""
	-- Permitir que Neovim abra enlaces con 'gx' en Windows
	vim.g.netrw_browsex_viewer = "cmd /c start"

	-- Limpieza de pantalla al salir usando la configuración de shell de Neovim
	vim.api.nvim_create_autocmd("VimLeave", {
		callback = function()
			-- Usamos la función interna de Neovim que ya sabe que usas pwsh
			vim.fn.system("cls")
		end,
	})
end
-- 0. CODIFICACIÓN Y LEADER (Debe ir al puro principio)
vim.g.mapleader = ","
-- 1. SOLUCIÓN PARA TREESITTER (Runtimepath)
local data_path = vim.fn.stdpath("data"):gsub("\\", "/")
local site_path = data_path .. "/site"

if not vim.tbl_contains(vim.opt.rtp:get(), site_path) then
	vim.opt.rtp:append(site_path)
end

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
