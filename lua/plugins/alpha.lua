return {
	"goolord/alpha-nvim",
	lazy = false,
	priority = 1000, -- Prioridad máxima para que sea lo primero que veas
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local dashboard = require("alpha.themes.dashboard")

		-- HEADER
		dashboard.section.header.val = {
			[[                                  ]],
			[[    ██████╗  ██████╗      ██╗███████╗]],
			[[   ██╔════╝ ██╔═══██╗     ██║██╔════╝]],
			[[   ██║  ███╗██║   ██║     ██║███████╗]],
			[[   ██║   ██║██║   ██║██   ██║╚════██║]],
			[[   ╚██████╔╝╚██████╔╝╚█████╔╝███████║]],
			[[    ╚═════╝  ╚═════╝  ╚════╝ ╚══════╝]],
			[[                                  ]],
			[[      DEVELOPER: JUAN CARLOS      ]],
			[[    GO LANG • JAVASCRIPT STACK    ]],
			[[                                  ]],
		}
		dashboard.section.header.opts.hl = "Keyword"

		-- FUNCIÓN DE BOTONES (Forma segura para Alpha)
		local function button(sc, txt, keybind, hl)
			local b = dashboard.button(sc, txt, keybind)
			b.opts.hl = hl or "Function"
			b.opts.hl_shortcut = "Number"
			return b
		end

		-- BOTONES
		dashboard.section.buttons.val = {
			button("f", "󰱼  BUSCAR ARCHIVO", "<cmd>Telescope find_files<CR>", "Label"),
			button("r", "󱋡  RECIENTES", "<cmd>Telescope oldfiles<CR>", "Special"),
			button("s", "󰺮  BUSCAR TEXTO", "<cmd>Telescope live_grep<CR>", "Function"),
			button("e", "󰙅  EXPLORADOR", "<cmd>NvimTreeToggle<CR>", "Type"),
			button("c", "  AJUSTES", "<cmd>edit $MYVIMRC<CR>", "Constant"),
			button("q", "󰈆  SALIR", "<cmd>qa<CR>", "Error"),
		}

		dashboard.section.footer.val = "󰚚  READY TO CODE"
		dashboard.section.footer.hl = "Comment"

		-- CONFIGURACIÓN DE INTEGRIDAD
		dashboard.opts.opts.noautocmd = true

		-- CARGAR ALPHA
		require("alpha").setup(dashboard.opts)

		-- FIX PARA WINDOWS (Solo borra si existe, sin matar el proceso)
		vim.api.nvim_create_autocmd("VimEnter", {
			once = true,
			callback = function()
				-- Solo limpiamos los settings que dan error, no el buffer de Alpha
				pcall(function()
					vim.api.nvim_del_augroup_by_name("alpha_settings")
				end)
			end,
		})
	end,
}
