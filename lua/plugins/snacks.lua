---@diagnostic disable: undefined-global
return {
	"folke/snacks.nvim",
	event = "VimEnter",
	priority = 1000,
	lazy = false,
	opts = {
		-- Desactiva lo que no usas para limpiar el reporte de errores
		image = { enabled = false },
		indent = { enabled = false },
		input = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		words = { enabled = false },
		debug = { enabled = false },
		terminal = { enabled = true }, -- Este sí déjalo para tu consola de Go
		bigfile = { enabled = true },
		-- 1. DASHBOARD (Tu logo y botones)
		dashboard = {
			animate = { enabled = true },
			enabled = true,
			sections = {
				{ section = "header" },
				{ section = "keys" },
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
						{ title = "Botonera", indent = 4, gap = 0, padding = 1 },
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
					{ icon = "󰉋 ", key = "p", desc = "Mis Proyectos", action = ":lua Snacks.picker.projects()" },
					-- Añadir en preset.keys
					{
						icon = "󰆼 ",
						key = "s",
						desc = "Bases de Datos (SQL)",
						action = function()
							Snacks.picker.files({ cwd = "C:/Users/Usuario/Documents/Desarrollo/Database" })
						end,
					},
					{ icon = " ", key = "m", desc = "Documentos md", action = ":OpenDocs" },
					{ icon = " ", key = "r", desc = "Recientes", action = ":lua Snacks.dashboard.pick('oldfiles')" },
					{
						icon = " ",
						key = "c",
						desc = "Configuración",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
					{ icon = " ", key = "q", desc = "Salir", action = ":qa" },
					{ title = "Documentación y Enlaces", indent = 4, gap = 0, padding = 1 }, -- Título de la nueva sección
					{
						icon = "󰟓 ",
						key = "G",
						desc = "Go Packages & Docs",
						action = function()
							vim.ui.open("https://pkg.go.dev/")
						end,
					},
					{
						icon = "󰙯 ",
						key = "v",
						desc = "Neovim Docs",
						action = function()
							vim.ui.open("https://neovim.io/doc/")
						end,
					},
					{
						icon = " ",
						key = "R",
						desc = "Mis Proyectos (GitHub)",
						action = function()
							vim.ui.open("https://github.com/juanca0423/")
						end,
					},
				},
				keys2 = {},
			},
		},
		picker = {
			enabled = true,
			sources = {
				files = { hidden = true },
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
		-- CAMBIO SUGERIDO: Usa Schedule para evitar que el dashboard se abra
		-- mientras Neovim todavía está limpiando la memoria del buffer anterior.
		vim.api.nvim_create_autocmd("BufDelete", {
			callback = function()
				vim.schedule(function() -- Esto da un respiro al editor
					local valid_bufs = vim.tbl_filter(function(b)
						return vim.api.nvim_buf_is_valid(b) and vim.bo[b].buflisted
					end, vim.api.nvim_list_bufs())

					if #valid_bufs == 0 and vim.bo.filetype ~= "snacks_dashboard" then
						require("snacks").dashboard.open()
					end
				end)
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
