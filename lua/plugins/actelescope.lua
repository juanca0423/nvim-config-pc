return {
	"nvim-telescope/telescope.nvim",
	-- ELIMINAMOS la línea de branch = "0.1.x" para usar la versión más nueva
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
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				-- SOLUCIÓN AL ERROR: Desactivamos el resaltado de Treesitter en la previsualización
				-- Esto evita que Telescope llame a la función 'ft_to_lang' que da error.
				preview = {
					treesitter = false,
				},
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						preview_width = 0.55,
						prompt_position = "top",
					},
				},
				file_ignore_patterns = {
					"node_modules",
					"vendor",
					"%.exe",
					"%.dll",
					"%.git/",
					"target/",
					"bin/",
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
		})

		-- Carga segura de extensiones
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "yank_history")
		pcall(telescope.load_extension, "ui-select")
	end,
}
