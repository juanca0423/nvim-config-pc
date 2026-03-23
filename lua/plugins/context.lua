return {
	"nvim-treesitter/nvim-treesitter-context",
	event = "BufReadPre",
	opts = {
		enable = true, -- Activar por defecto
		max_lines = 3, -- Cuántas líneas mostrar (para que no ocupe mucha pantalla)
		trim_scope = "outer", -- Qué mostrar si la función es muy grande
		mode = "cursor", -- Seguir al cursor
	},
}
