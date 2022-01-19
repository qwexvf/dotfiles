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
vim.cmd 'autocmd filetype plugin indent on'

-- vim.cmd 'autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()'
vim.cmd 'autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting()'
vim.cmd 'au FileType go setlocal sw=4 ts=4 sts=4 noet'
vim.cmd 'au FileType elm setlocal sw=4 ts=4 sts=4 noet'
vim.cmd 'au FileType typescript,ts setlocal sw=4 ts=4 sts=4 noet'

vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
