return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	-- Cambiamos a un evento que asegure que Alpha ya se dibujó
	event = "BufReadPost",
	opts = {
		options = {
			mode = "buffers",
			separator_style = "slant",
			show_buffer_close_icons = true,
			show_close_icon = false,
			diagnostics = "nvim_lsp",
			-- PROTECCIÓN: Ignorar buffers que no son archivos (Alpha, Dashboard)
			offsets = {
				{
					filetype = "NvimTree",
					text = "EXPLORADOR",
					text_align = "left",
					separator = true,
				},
			},
			-- Evita que bufferline intente mostrar buffers "fantasma" como el de Yanky
			custom_filter = function(buf_number)
				local ft = vim.bo[buf_number].filetype
				if ft == "alpha" or ft == "dashboard" or ft == "yanky" then
					return false
				end
				return true
			end,
		},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)

		-- ATAJOS PARA TUS BUFFERS
		vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Siguiente Buffer" })
		vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Anterior Buffer" })
		-- Cambiamos bdelete por uno más seguro que no rompa el layout
		vim.keymap.set("n", "<leader>q", "<cmd>bp|sp|bn|bd<cr>", { desc = "Cerrar Buffer sin romper split" })
		vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Elegir cerrar" })
	end,
}
