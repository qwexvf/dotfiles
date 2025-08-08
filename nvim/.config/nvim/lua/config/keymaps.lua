local noremap = { noremap = true, silent = true }
local map = vim.keymap.set

-- map Esc to jj
map("i", "jj", "<Esc>", noremap)
map("n", "<Esc>", "<cmd>set hlsearch!<CR>", noremap)

-- Add leader shortcuts
map("n", "<space>fb", function()
  require("fzf-lua").buffers()
end, noremap)

map("n", "<space>sf", function()
  require("fzf-lua").files()
end, noremap)

map("n", "<space>sb", function()
  require("fzf-lua").lgrep_curbuf()
end, noremap)

map("n", "<space>sh", function()
  require("fzf-lua").help_tags()
end, noremap)
map("n", "<space>sd", function()
  require("fzf-lua").grep_cword()
end, noremap)
map("n", "<space>sp", function()
  require("fzf-lua").live_grep()
end, noremap)

map("n", "<space>?", function()
  require("fzf-lua").oldfiles()
end, noremap)

map("n", "<leader>ca", vim.lsp.buf.code_action)
