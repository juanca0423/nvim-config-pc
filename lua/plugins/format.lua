return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			-- Para Go usamos goimports (que hace el auto-import) y gofmt
			go = { "goimports", "gofumpt" },
			-- Para JS y Web usamos Prettier
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier" },
			html = { "prettierd", "prettier" },
			handlebars = { "prettierd", "prettier" },
			css = { "prettierd", "prettier" },
		},
		format_on_save = {
			timeout_ms = 1000, -- Un segundo es ideal para Windows
			lsp_format = "fallback", -- Si no hay formateador, usa el LSP
		},
	},
}
