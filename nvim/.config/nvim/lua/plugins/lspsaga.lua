local config = function()
  require("lspsaga").setup {
    ui = {
      code_action = "",
    },
  }

  local keymap = vim.keymap.set
  -- Lsp finder find the symbol definition implement reference
  -- if there is no implement it will hide
  -- when you use action in finder like open vsplit then you can
  -- use <C-t> to jump back
  keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

  -- Code action
  keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

  -- Rename
  keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

  -- Peek Definition
  -- you can edit the definition file in this flaotwindow
  -- also support open/vsplit/etc operation check definition_action_keys
  -- support tagstack C-t jump back
  keymap("n", "gD", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
  keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { silent = true })

  -- Show line diagnostics
  keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

  -- Show cursor diagnostic
  keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

  -- Diagnsotic jump can use `<c-o>` to jump back
  keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
  keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

  -- Only jump to error
  keymap("n", "[E", function()
    require("lspsaga.diagnostic").goto_prev { severity = vim.diagnostic.severity.ERROR }
  end, { silent = true })
  keymap("n", "]E", function()
    require("lspsaga.diagnostic").goto_next { severity = vim.diagnostic.severity.ERROR }
  end, { silent = true })

  -- Outline
  keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })

  -- Hover Doc
  keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

  -- Float terminal
  keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
  -- if you want pass somc cli command into terminal you can do like this
  -- open lazygit in lspsaga float terminal
  keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
  -- close floaterm
  keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
end

return {
  "nvimdev/lspsaga.nvim",
  lazy = false,
  config = config,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
