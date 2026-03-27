return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern", -- Se ve genial con Catppuccin
		spec = {
			{ "<leader>f", group = "Archivos" },
			{ "<leader>g", group = "Git/Búsqueda" },
			{ "<leader>s", group = "SQL/Database" },
			{ "<leader>t", group = "Terminal/Explorer" },
		},
	},
}
