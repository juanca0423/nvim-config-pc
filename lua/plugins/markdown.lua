return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	-- LA CLAVE: Solo carga cuando abras estos archivos
	ft = { "markdown", "codecompanion" },
	config = function()
		require("render-markdown").setup({
			-- Aquí movimos tus ajustes personalizados
			file_types = { "markdown", "codecompanion" },
			html = { enabled = false },
			latex = { enabled = false },
			yaml = { enabled = false },
			heading = {
				-- Tus iconos personalizados
				icons = { "◉ ", "○ ", "✸ ", "✿ " },
			},
		})
	end,
}
