return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		event = "VeryLazy",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			local luasnip = require("luasnip")
			luasnip.setup({
				keep_roots = true,
				link_roots = true,
				link_children = true,
			})
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
		},
	},

	-- 3. Iconos y EstÃ©tica
	{
		"onsails/lspkind.nvim",
		config = function()
			require("lspkind").init({
				mode = "symbol_text", -- Muestra el icono y el texto (ej: 󰅩 Function)
				preset = "codicons",
				symbol_map = {
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",
					Field = "󰜢",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎟",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "󰈚",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "",
				},
			})
		end,
	},
	-- 4. Kulala (Cliente HTTP para Go/APIs)
	{
		"mistweaverco/kulala.nvim",
		keys = {
			{
				"<leader>hr",
				function()
					require("kulala").run()
				end,
				desc = "Ejecutar peticiÃ³n HTTP",
			},
			{
				"<leader>hv",
				function()
					require("kulala").toggle_view()
				end,
				desc = "Cambiar vista (Cuerpo/Headers)",
			},
			{
				"<leader>hn",
				function()
					require("kulala").jump_next()
				end,
				desc = "Siguiente peticiÃ³n",
			},
			{
				"<leader>hp",
				function()
					require("kulala").jump_prev()
				end,
				desc = "PeticiÃ³n anterior",
			},
		},
		-- En tu archivo de configuración de Kulala
		opts = {
			display_mode = "split",
			split_direction = "vertical", -- Mejora para ver tu API a la par del código
			default_view = "body",
			icons = {
				passed = "✔", -- O usa el icono: 
				failed = "✖", -- O usa el icono: 
				running = "󱎯", -- Este es el de carga
			},
		},
	},
}
