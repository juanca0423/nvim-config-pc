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
vim.scriptencoding = "utf-8"

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
-- Handlers de LSP (Versión corregida para Nvim 0.12+)
vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
	return vim.lsp.handlers.hover(err, result, ctx, vim.tbl_extend("force", config or {}, { border = "rounded" }))
end

vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
	return vim.lsp.handlers.signature_help(
		err,
		result,
		ctx,
		vim.tbl_extend("force", config or {}, { border = "rounded" })
	)
end -- Forzar la ayuda en español

vim.opt.helplang = "en"
