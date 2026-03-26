return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true, -- Cierra etiquetas automáticamente: <div> -> <div></div>
				enable_rename = true, -- Si cambias <div> por <section>, cambia el de cierre también
				enable_close_on_slash = true, -- Cierra al poner /
			},
		})
	end,
}
