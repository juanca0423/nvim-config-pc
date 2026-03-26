return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		-- En tu archivo de Conform
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "gofumpt" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			-- Handlebars lo dejamos vacío para que use el LSP_FORMAT fallback (el que sí te funcionó)
			handlebars = {},
			css = { "prettierd", "prettier", stop_after_first = true },
		},
		format_on_save = {
			timeout_ms = 1000, -- Un segundo es ideal para Windows
			lsp_format = "fallback", -- Si no hay formateador, usa el LSP
		},
	},
}
