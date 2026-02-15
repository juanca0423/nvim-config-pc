return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "fredrikaverpil/neotest-golang",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-golang")({
          runner = "go",
          go_test_args = { "-v", "-count=1" },
          is_test_file = function(file_path)
            return file_path:match("_test%.go$") ~= nil
          end,
          dap_go_enabled = true,
        }),
      },
      icons = {
        passed = "󰄬 ",
        running = " ",
        failed = "󰅖 ",
        skipped = "󰒲 ",
        unknown = "󰇼 ",
        watching = "󰈈 ",
      },
      highlights = {
        passed = "NeotestPassed",
        failed = "NeotestFailed",
        running = "NeotestRunning",
        skipped = "NeotestSkipped",
        unknown = "NeotestUnknown",
      },
      summary = {
        expand_errors = true,
        follow = true,
        mappings = {
          expand = { "<CR>", "o" },
          expand_all = "e",
          output = "O",
          run = "r",
          short = "i",
          stop = "u",
        },
      },
      output = {
        enabled = true,
        open_on_run = "short",
      },
      status = {
        enabled = true,
        virtual_text = true,
        signs = true,
      },
    })

    -- Colores
    vim.api.nvim_set_hl(0, "NeotestPassed", { fg = "#98be65" })
    vim.api.nvim_set_hl(0, "NeotestFailed", { fg = "#ff6c6b" })
    vim.api.nvim_set_hl(0, "NeotestRunning", { fg = "#ecbe7b" })

    -- ATAJOS
    vim.keymap.set("n", "nnr", function() neotest.run.run() end, { desc = "Correr Test Cercano" })
    vim.keymap.set("n", "nnf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Correr Tests del Archivo" })
    vim.keymap.set("n", "nna", function() neotest.run.run({ suite = true }) end, { desc = "Correr Toda la Suite" })
    vim.keymap.set("n", "nns", function() neotest.summary.toggle() end, { desc = "Alternar Panel Lateral" })
    vim.keymap.set("n", "nno", function() neotest.output.open({ enter = true, last_run = true }) end,
      { desc = "Ver Error Flotante" })
    vim.keymap.set("n", "nnp", function() neotest.output_panel.toggle() end, { desc = "Alternar Panel de Consola" })

    local neotest_group = vim.api.nvim_create_augroup("NeotestConfig", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = neotest_group,
      pattern = "*.go",
      callback = function()
        -- Usamos pcall para que no explote si Neotest no está listo
        pcall(function() neotest.run.run(vim.fn.expand("%")) end)
      end,
    })
  end, -- Aquí termina la función config
}
