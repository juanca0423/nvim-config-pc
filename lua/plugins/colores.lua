return {
	"brenoprata10/nvim-highlight-colors",
	config = function()
		require("nvim-highlight-colors").setup({
			render = "background", -- Esto pondrá el color de fondo en el código hex
			enable_named_colors = true,
			enable_tailwind = true, -- Útil si usas Tailwind en tus proyectos JS
		})
	end,
}
