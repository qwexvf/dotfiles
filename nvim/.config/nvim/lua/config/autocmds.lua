local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Spell checking for specific filetypes
augroup("SpellCheck", { clear = true })
autocmd("FileType", {
  group = "SpellCheck",
  pattern = { "markdown", "gitcommit", "text", "plaintex", "tex" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Common indent settings for web/scripting languages (2 spaces)
augroup("IndentSettings", { clear = true })
autocmd("FileType", {
  group = "IndentSettings",
  pattern = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "lua",
    "gleam",
    "html",
    "css",
    "scss",
    "json",
    "yaml",
    "elixir",
    "heex",
    "eelixir",
  },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.formatoptions:append({ c = true, r = true, o = true, q = true })
  end,
})

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = "TrimWhitespace",
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Return to last edit position when opening files
augroup("LastPosition", { clear = true })
autocmd("BufReadPost", {
  group = "LastPosition",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
