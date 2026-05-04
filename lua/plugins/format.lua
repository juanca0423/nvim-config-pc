return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "gofumpt" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			-- ACTUALIZADO: Usamos ember-template-lint (que incluye Glimmer) o glimmer
			handlebars = { "prettier" },
			["handlebars.html"] = { "prettier" },
			css = { "prettier" },
			ps1 = { "powershell_editor_services" },
		},
		formatters = {
			prettier = {
				-- Forzamos el parser de glimmer que sí soporta hbs
				args = {
					"--stdin-filepath",
					"$FILENAME",
					"--parser",
					"html",
					"--print-width",
					"120", -- Cámbialo a 100 o 120 según prefieras
					"--tab-width",
					"2",
				},
			},
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
	},
}
