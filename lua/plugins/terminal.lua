return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local toggleterm = require("toggleterm")

		toggleterm.setup({
			size = 20,
			open_mapping = [[<c-\>]], -- Ctrl + \ para abrir/cerrar rápido
			hide_numbers = true,
			shade_terminals = true,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			direction = "float", -- Flotante por defecto
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved", -- Estilo redondeado
				winblend = 3,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})

		-- MAPEOS INTERNOS DE LA TERMINAL
		-- Usamos un autocomando de Lua puro (más moderno)
		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*",
			callback = function()
				local opts = { buffer = 0 }
				-- Escapar del modo terminal con Esc Esc o jk
				vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)

				-- Navegación entre ventanas desde la terminal
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			end,
		})

		-- SHORTCUTS DE LÍDER
		local opts = { noremap = true, silent = true }
		-- <leader>tf para la Flotante (tu actual)
		vim.keymap.set("n", "<leader>tf", "<Cmd>ToggleTerm direction=float<CR>", opts)
		-- <leader>th para una terminal Horizontal (útil para ver logs mientras programas)
		vim.keymap.set("n", "<leader>th", "<Cmd>ToggleTerm size=15 direction=horizontal<CR>", opts)
	end,
}
