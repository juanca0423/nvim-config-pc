---@diagnostic disable: undefined-global
return {
	"folke/snacks.nvim",
	event = "VimEnter",
	priority = 1000,
	lazy = false,
	opts = {
		-- Desactiva lo que no usas para limpiar el reporte de errores
		image = { enabled = false },
		terminal = { enabled = true }, -- Este sí déjalo para tu consola de Go
		bigfile = { enabled = true },
		-- 1. DASHBOARD (Tu logo y botones)
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ section = "keys", title = "Botonera", gap = 0, padding = 1 },
				{ icon = " ", title = "Proyectos de Go", section = "projects", indent = 2, padding = 1 },
				{ section = "startup" },
			},
			preset = {
				header = [[
   ██████╗  ██████╗      ██╗███████╗
  ██╔════╝ ██╔═══██╗     ██║██╔════╝
  ██║  ███╗██║   ██║     ██║███████╗
  ██║   ██║██║   ██║██   ██║╚════██║
  ╚██████╔╝╚██████╔╝╚█████╔╝███████║
   ╚═════╝  ╚═════╝  ╚════╝ ╚══════╝

      DEVELOPER: JUAN CARLOS
    GO • JS • HTML • CSS STACK]],
				keys = {
					{
						icon = " ",
						key = "f",
						desc = "Buscar Archivo",
						action = ":lua Snacks.dashboard.pick('files')",
					},
					{ icon = " ", key = "n", desc = "Nuevo Archivo", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Buscar Texto",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recientes",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Configuración",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
					{ icon = " ", key = "q", desc = "Salir", action = ":qa" },
				},
			},
		},

		-- 2. EXPLORADOR (Configuración Reforzada)
		explorer = {
			enabled = true,
			replace_netrw = true,
		},

		-- 3. WINBAR (Ruta en los archivos que editas)
		winbar = { enabled = true },

		-- 4. NOTIFICACIONES
		notifier = { enabled = true },

		-- 5. ESTILOS (Ajuste definitivo para Windows/PowerShell)
		styles = {
			explorer = {
				width = 35,
				edge = "left",
				-- Obligamos a que el TÍTULO sea la ruta del proyecto
				title = function()
					return "   " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~") .. " "
				end,
				title_pos = "center",

				-- Configuramos la ventana para que sea más robusta
				win = {
					border = "rounded", -- Borde redondeado para que se vea el título
					wo = {
						winbar = "", -- Limpiamos winbar interno por si hace conflicto
					},
				},
				-- Quitamos el header automático que está fallando y dejamos solo el árbol
				sections = {
					{ section = "tree" },
				},
			},
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		-- Autocomando para el dashboard
		vim.api.nvim_create_autocmd("BufDelete", {
			callback = function()
				local bufs = vim.api.nvim_list_bufs()
				local valid_bufs = 0
				for _, buf in ipairs(bufs) do
					if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
						valid_bufs = valid_bufs + 1
					end
				end
				if valid_bufs == 0 then
					require("snacks").dashboard.open()
				end
			end,
		})

		-- TUS MAPEOS
		vim.keymap.set("n", "<leader>t", function()
			Snacks.explorer()
		end, { desc = "Explorador" })
		-- Dentro de config = function(_, opts)
		vim.keymap.set("n", "<leader>lg", function()
			Snacks.lazygit()
		end, { desc = "Abrir Lazygit" })
		vim.keymap.set("n", "<leader>aa", function()
			Snacks.dashboard.open()
		end, { desc = "Dashboard" })
	end,
}
