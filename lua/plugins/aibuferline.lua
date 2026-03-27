return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy", -- Cambiamos a VeryLazy para evitar conflictos de carga
	opts = {
		options = {
			mode = "buffers",
			-- Cambiamos esto por la forma nativa que usa nvim-web-devicons
			show_buffer_icons = true,

			-- ELIMINAMOS get_element_icon para que use el default que sí funciona
			-- Bufferline ya sabe buscar los iconos si tienes nvim-web-devicons instalado

			separator_style = "slant",
			show_buffer_close_icons = true,
			show_close_icon = false,
			diagnostics = "nvim_lsp",

			offsets = {
				{
					filetype = "snacks_explorer",
					text = " EXPLORADOR ",
					text_align = "left",
					separator = true,
				},
			},
			-- ... resto de tu custom_filter igual

			custom_filter = function(buf_number)
				local ft = vim.bo[buf_number].filetype
				local exclude = {
					["alpha"] = true,
					["dashboard"] = true,
					["snacks_dashboard"] = true,
					["yanky"] = true,
					["lazy"] = true,
				}
				return not exclude[ft]
			end,
		},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)

		-- Mapeos rápidos
		vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>")
		vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")
		-- Cerrar buffer sin romper la interfaz
		vim.keymap.set("n", "<leader>q", "<cmd>bp|bd #<cr>", { desc = "Cerrar Buffer" })
	end,
}
