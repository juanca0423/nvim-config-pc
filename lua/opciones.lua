-- 1. RENDIMIENTO
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500

-- 2. INTERFAZ
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- 3. INDENTACIÓN (2 ESPACIOS) - global, filetype plugins sobrescriben si necesario
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- 4. PORTAPAPELES
-- Portapapeles usando win32yank (Adiós a los errores de PowerShell)
if vim.fn.executable("win32yank.exe") == 1 then
	vim.g.clipboard = {
		name = "win32yank-static",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end
vim.opt.clipboard = "unnamedplus"

-- 5. DIAGNÓSTICOS
local icons = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
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
	float = { border = "rounded", source = "if_many" },
})

-- Handlers de LSP (Nvim 0.12+: usar vim.lsp.config o configurar borders globalmente)
vim.o.winborder = "rounded"

vim.opt.helplang = "en"
