-- Silenciar avisos de funciones obsoletas (Neovim 0.10+)
vim.g.deprecation_warnings = false

vim.g.mapleader = ","
vim.g.maplocalleader = ","
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

-- Configuración de lazy.nvim
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

-- CONFIGURACIÓN DE LAZY
require("lazy").setup("plugins", {
	change_detection = { notify = false },
	checker = { enabled = true },
	performance = {
		cache = { enabled = true },
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
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
			lazy = "💤",
		},
	},
	rocks = { enabled = false },
})

-- Carga segura de módulos personalizados
pcall(require, "opciones")
pcall(require, "mapas")
pcall(require, "config.autocomandos")
pcall(function()
	require("config.generate_cheatsheet").setup()
end)
