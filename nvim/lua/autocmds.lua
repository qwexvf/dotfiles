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

cmd([[
	au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
]])

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'
