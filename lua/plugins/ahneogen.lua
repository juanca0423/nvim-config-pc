return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	-- LA CLAVE: No cargar hasta que presiones uno de los atajos
	keys = {
		{
			"<leader>nf",
			function()
				require("neogen").generate({ type = "func" })
			end,
			desc = "Doc Función",
		},
		{
			"<leader>nc",
			function()
				require("neogen").generate({ type = "class" })
			end,
			desc = "Doc Struct",
		},
		{
			"<leader>np",
			function()
				require("neogen").generate({ type = "file" })
			end,
			desc = "Doc Paquete",
		},
	},
	config = function()
		require("neogen").setup({
			enabled = true,
			-- Saltos inteligentes: al generar la doc, pulsa <Tab> para ir al siguiente campo
			input_after_comment = true,
			languages = {
				javascript = { template = { annotation_convention = "jsdoc" } },
				typescript = { template = { annotation_convention = "tsdoc" } },
				go = { template = { annotation_convention = "godoc" } },
			},
		})
	end,
}
