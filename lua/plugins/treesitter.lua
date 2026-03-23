return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local parser_path = (vim.fn.stdpath("data") .. "/site"):gsub("\\", "/")
			--vim.opt.runtimepath:prepend(parser_install_dir)

			-- 2. Usamos pcall para cargar la config de forma segura
			local ok, configs = pcall(require, "nvim-treesitter.configs")
			if not ok then
				return
			end

			configs.setup({
				parser_install_dir = parser_path,
				-- En tu lista de ensure_installed dentro de treesitter.lua, añade estos:
				ensure_installed = {
					"lua",
					"go",
					"javascript",
					"typescript",
					"markdown",
					"vim",
					"vimdoc",
					"query",
					"sql",
					"html",
					"css",
					"http",
					"embedded_template", -- Para HTML y CSS estándar
					"glimmer", -- El parser para Ember.js / Glimmer
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
		opts = { max_lines = 3 },
	},
}
