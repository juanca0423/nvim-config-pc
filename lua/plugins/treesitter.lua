return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleStat", "TSTree", "TSUpdate" },
		config = function()
			local parser_path = vim.fn.stdpath("data"):gsub("\\", "/") .. "/site"

			if vim.fn.isdirectory(parser_path) == 0 then
				vim.fn.mkdir(parser_path, "p")
			end

			vim.opt.runtimepath:append(parser_path)

			local ok, configs = pcall(require, "nvim-treesitter.configs")
			if not ok then
				return
			end

			configs.setup({
				parser_install_dir = parser_path,
				ensure_installed = {
					"lua",
					"go",
					"javascript",
					"typescript",
					"markdown",
					"vim",
					"vimdoc",
					"query",
					"sql",
					"html",
					"css",
					"http",
					"embedded_template",
					"glimmer",
					"markdown_inline",
				},
				highlight = {
					enable = true,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local oki, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if oki and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				indent = { enable = true },
			})

			-- MOVIMOS EL COMANDO AQUÍ ADENTRO:
			vim.api.nvim_create_user_command("TSCheckPath", function()
				local p_path = vim.fn.stdpath("data"):gsub("\\", "/") .. "/site/parser"
				print("📍 Buscando parsers en: " .. p_path)
				local files = vim.fn.readdir(p_path)
				if #files > 0 then
					print("✅ Encontrados " .. #files .. " archivos.")
					for i = 1, math.min(3, #files) do
						print("  - " .. files[i])
					end
				else
					print("⚠️  La carpeta está vacía.")
				end
			end, {})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
		opts = { max_lines = 3 },
	},
}
