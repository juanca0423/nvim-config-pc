return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "BufRead",
	opts = {
		keywords = {
			FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
			TODO = { icon = " ", color = "info" }, -- Color azul Catppuccin
			HACK = { icon = " ", color = "warning" }, -- Color amarillo/naranja
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		},
		highlight = {
			multiline = true,
			before = "", -- "fg" o vacio
			keyword = "wide", -- "fg", "bg", "wide"
			after = "fg",
		},
	},
}
