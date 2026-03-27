return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "gofumpt" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			-- ACTUALIZADO: Usamos ember-template-lint (que incluye Glimmer) o glimmer
			handlebars = { "glimmer" },
			css = { "prettierd", "prettier", stop_after_first = true },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
	},
}
