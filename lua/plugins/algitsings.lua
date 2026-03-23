return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local gs = require("gitsigns")
		gs.setup({
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "┆" },
			},
			current_line_blame = true, -- Blame automático en la línea actual
			current_line_blame_opts = { delay = 500, virt_text_pos = "eol" },
			on_attach = function(bufnr)
				-- Navegación rápida entre cambios (Hunks)
				vim.keymap.set("n", "]h", function()
					gs.nav_hunk("next")
				end, { buffer = bufnr, desc = "Siguiente cambio Git" })
				vim.keymap.set("n", "[h", function()
					gs.nav_hunk("prev")
				end, { buffer = bufnr, desc = "Anterior cambio Git" })

				-- Acciones de Git
				vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Previsualizar cambio" })
				vim.keymap.set("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, { buffer = bufnr, desc = "Ver Blame completo" })
				vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "Ver Diff de archivo" })
			end,
		})
	end,
}
