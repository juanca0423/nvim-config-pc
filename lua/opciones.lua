-- 1. RENDIMIENTO
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500

-- 2. INTERFAZ
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.cursorline = true

-- 3. INDENTACIÓN (2 ESPACIOS)
vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "FileType" }, {
	pattern = "*",
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})

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
	float = { border = "rounded", source = "always" },
})

-- Handlers de LSP
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
