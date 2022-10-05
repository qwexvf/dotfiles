local cmd = vim.cmd -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript

vim.g.did_load_filetypes = 1

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

cmd "autocmd BufWritePost plugins.lua PackerCompile"
cmd "highlight WinSeparator guibg=None"

cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

cmd "au BufRead,BufNewFile Earthfile set filetype=Earthfile"
cmd "au BufRead,BufNewFile build.earth set filetype=Earthfile"
