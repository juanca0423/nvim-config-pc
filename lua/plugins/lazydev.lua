-- lua/plugins/lazydev.lua
return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- solo carga para archivos lua
		opts = {
			library = {
				-- Carga los tipos de la API de Neovim
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "Lazy" } },
			},
		},
	},
}
