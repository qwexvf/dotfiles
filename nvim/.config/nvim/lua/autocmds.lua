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

cmd "highlight WinSeparator guibg=None"
cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
