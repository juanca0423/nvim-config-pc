return {
	{
		-- Este es el estándar, el otro tenía el link roto
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				-- Detecta la raíz de tu proyecto buscando el .git o go.mod
				detection_methods = { "lsp", "pattern" },
				patterns = { ".git", "go.mod", "Makefile", "package.json" },
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local lint = require("lint")
			-- Tu configuración de sqlfluff que ya tenemos...
			lint.linters_by_ft = {
				sql = { "sqlfluff" },
			}
			-- Autocomando para que revise el SQL cada vez que guardes
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				sql = { "sql_formatter" },
			},
		},
	},
	-- ... el resto de conform.nvim que ya pusimos
}
