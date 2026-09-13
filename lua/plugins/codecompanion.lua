return {
	{
		"olimorris/codecompanion.nvim",
		keys = {
			{ "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle AI Chat" },
			{ "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = "v", desc = "AI Actions" },
			{ "<leader>ae", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "AI Inline Command" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "ollama",
						-- Forzamos al chat a usar el prompt del sistema en español
						opts = {
							system_prompt = "Eres un programador experto en Go. DEBES responder SIEMPRE en español, de forma clara, concisa y profesional.",
						},
					},
					inline = {
						adapter = "ollama",
						opts = {
							system_prompt = "Eres un programador experto en Go. DEBES responder SIEMPRE en español.",
						},
					},
				},
				adapters = {
					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							schema = {
								model = {
									default = "qwen2.5-coder:3b",
								},
							},
						})
					end,
				},
			})
		end,
	},
}
