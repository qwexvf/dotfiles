local builtin = require "telescope.builtin"

local noremap = { noremap = true, silent = true }
local map = vim.keymap.set

-- map Esc to jj
map("i", "jj", "<Esc>", noremap)
map("n", "<Esc>", "<cmd>set hlsearch!<CR>", noremap)

-- Add leader shortcuts
map("n", "<space>fb", function()
  builtin.buffers()
end, noremap)

map("n", "<space>sf", function()
  builtin.find_files()
end, noremap)

map("n", "<space>sb", function()
  builtin.current_buffer_fuzzy_find()
end, noremap)

map("n", "<space>sh", function()
  builtin.help_tags()
end, noremap)
map("n", "<space>sd", function()
  builtin.grep_string()
end, noremap)
map("n", "<space>sp", function()
  builtin.live_grep()
end, noremap)

map("n", "<space>?", function()
  builtin.oldfiles()
end, noremap)
