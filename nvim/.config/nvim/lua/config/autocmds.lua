local cmd = vim.cmd -- execute Vim commands
local exec = vim.api.nvim_exec2 -- execute Vimscript

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
  {}
)

--Highlight on yank
exec(
  [[
	augroup YankHighlight
	autocmd!
	autocmd TextYankPost * silent! lua vim.highlight.on_yank()
	augroup end
	]],
  {}
)

cmd("highlight WinSeparator guibg=None")
cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("go.format").goimport()
  end,
  group = format_sync_grp,
})
