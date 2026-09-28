return {
	"nacro90/numb.nvim",
	event = "BufRead",
	config = function()
		require("numb").setup({
			show_numbers = true, -- Muestra el número de línea en el preview
			show_cursorline = true, -- Resalta la línea a la que vas a saltar
			number_only = false, -- Si escribes :10, funciona igual
			-- Campos requeridos por el tipo NumbConfig (defaults)
			hide_relativenumbers = false,
			centered_peeking = true,
			range_peek = true,
			disable_for_buftype = { "terminal", "nofile" },
			disable_for_filetype = {},
			peek_style = "auto",
			float = {
				enabled = false,
				border = "rounded",
				height = 0.5,
				position = "auto",
			},
		})
	end,
}
