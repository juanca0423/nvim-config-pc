return {
  {
    "tpope/vim-dadbod",
    lazy = false,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod",                     lazy = false },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = false },
    },
    cmd = {
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUI",
      "DBUIFindBuffer",
      "DBUIRenameBuffer",
      "DBUILastQueryInfo",
    },
    keys = {
      { "<leader>db", "<cmd>DBUIToggle<cr>",       desc = "Toggle UI de Base de Datos" },
      -- ESTO ES LO QUE FALTABA:
      { "<leader>S",  "<Plug>(DBUI_ExecuteQuery)", mode = { "n", "v" },                desc = "Ejecutar Query SQL" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_help = 0
      vim.g.db_ui_win_position = "left"
      vim.g.db_ui_save_queries = 1
    end,
  },
}
