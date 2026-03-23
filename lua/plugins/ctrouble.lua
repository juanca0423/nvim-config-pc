return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	opts = {
		auto_close = true,
		restore_window_config = false,
		padding = false,
		-- Añadimos modos específicos para que sea más útil
		modes = {
			diagnostics = {
				groups = {
					{ "filename", format = "{fileicon} {filename} {count}" },
				},
			},
			-- Modo para ver dónde se usa una función (ideal para tus proyectos de Go)
			lsp_references = {
				params = {
					include_declaration = false,
				},
			},
		},
		icons = {
			indent = {
				top = "│ ",
				middle = "├ ",
				last = "└ ",
				fold_open = " ",
				fold_closed = " ",
				ws = "  ",
			},
		},
	},
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Proyecto: Errores" },
		{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Archivo Actual: Errores" },
		-- ¡ESTE ES NUEVO! Muestra dónde se usa la función bajo el cursor
		{ "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP: Referencias" },
		-- Para ver tus TODOs en una lista bonita de Trouble
		{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Lista de TODOs" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
	},
}

--[[
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  opts = {
    auto_close = true,
    restore_window_config = false,
    padding = false,
    -- Estilo más moderno para las señales de error
    icons = {
      indent = {
        top = "│ ",
        middle = "├ ",
        last = "└ ",
        fold_open = " ",
        fold_closed = " ",
        ws = "  ",
      },
    },
  },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Proyecto: Errores" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer: Errores" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>",                 desc = "Quickfix List" },
  },
}
]]
