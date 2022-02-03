local cmd = vim.cmd -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript

exec(
  [[
	if !exists("g:os")
			if has("win64") || has("win32") || has("win16")
					let g:os = "Windows"
			else
					let g:os = substitute(system('uname'), '\n', '', '')
			endif
	endif
	]],
  false
)

cmd 'filetype plugin indent on'

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

cmd 'autocmd BufWritePost plugins.lua PackerCompile'

-- vim.cmd 'autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()'
cmd 'autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting()'
cmd 'au FileType go setlocal sw=4 ts=4 sts=4 noet'
cmd 'au FileType elm setlocal sw=4 ts=4 sts=4 noet'
cmd 'au FileType typescript,ts setlocal sw=4 ts=4 sts=4 noet'
cmd 'au FileType lua setlocal sw=2 ts=2 sts=2 noet'
cmd 'au FileType elixir setlocal sw=2 ts=2 sts=2 noet'

cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

cmd 'au BufRead,BufNewFile Earthfile set filetype=Earthfile'
cmd 'au BufRead,BufNewFile build.earth set filetype=Earthfile'
