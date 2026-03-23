return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	cmd = "Telescope", -- Solo carga cuando escribes :Telescope o usas un atajo
	-- CAMBIO CLAVE: Solo carga cuando presiones una de estas teclas
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Buscar archivos" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Buscar texto" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Ayuda" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				layout_strategy = "vertical",
				layout_config = { vertical = { mirror = true, prompt_position = "top" } },
				sorting_strategy = "ascending",
			},
		})

		-- Carga segura de extensiones solo cuando el plugin se activa
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
		pcall(telescope.load_extension, "yank_history")
	end,
}
