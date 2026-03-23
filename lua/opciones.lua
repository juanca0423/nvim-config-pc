-- ==========================================================================
-- 1. RENDIMIENTO Y PROVIDERS
-- ==========================================================================
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.opt.shada = "!,'100,<50,s10,h"
-- Explicación:
-- '100 : Guarda marcas para los últimos 100 archivos.
-- <50  : Guarda un máximo de 50 líneas por registro.
-- s10  : Máximo 10kb por item.
vim.opt.updatetime = 300 -- Respuesta más rápida de la interfaz
vim.opt.timeoutlen = 500 -- Tiempo de espera para atajos (Leader)

-- ==========================================================================
-- 2. INTERFAZ VISUAL
-- ==========================================================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 0
vim.opt.laststatus = 3 -- Barra de estado global (estilo moderno)
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.cursorline = true -- Resalta la línea actual visualmente

-- ==========================================================================
-- 3. EDICIÓN Y COMPORTAMIENTO
-- ==========================================================================
vim.opt.smartcase = true
vim.opt.ignorecase = true -- Necesario para que smartcase funcione bien
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.undofile = true -- Historial de "deshacer" persistente incluso al cerrar
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Menú de comandos inteligente
vim.opt.wildignorecase = true
vim.opt.wildmode = "longest:full,full"
vim.opt.clipboard = "unnamedplus"
-- ==========================================================================
-- 4. DIAGNÓSTICOS (Iconos y Ventanas flotantes)
-- ==========================================================================
local icons = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }

vim.diagnostic.config({
	virtual_text = { prefix = "󰄴", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.Error,
			[vim.diagnostic.severity.WARN] = icons.Warn,
			[vim.diagnostic.severity.HINT] = icons.Hint,
			[vim.diagnostic.severity.INFO] = icons.Info,
		},
	},
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		focusable = true,
	},
})

-- Bordes redondeados para ventanas de ayuda (K)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
