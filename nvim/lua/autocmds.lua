local cmd = vim.cmd -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript
local fn = vim.fn -- call Vim functions
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options

--Highlight on yank
exec(
  [[
	augroup YankHighlight
	autocmd!
	autocmd TextYankPost * silent! lua vim.highlight.on_yank()
	augroup end
	]],
  false
)

cmd [[
	au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
]]

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

function PrintDiagnostics(opts, bufnr, line_nr, client_id)
  opts = opts or {}

  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)

  local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
  if vim.tbl_isempty(line_diagnostics) then
    return
  end

  local diagnostic_message = ''
  for i, diagnostic in ipairs(line_diagnostics) do
    diagnostic_message = diagnostic_message .. string.format('%d: %s', i, diagnostic.message or '')
    print(diagnostic_message)
    if i ~= #line_diagnostics then
      diagnostic_message = diagnostic_message .. '\n'
    end
  end
  vim.api.nvim_echo({ { diagnostic_message, 'Normal' } }, false, {})
end

-- vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]

vim.cmd 'autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics{focusable=false}'

-- vim.cmd 'autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()'
