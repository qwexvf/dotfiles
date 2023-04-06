local map = vim.api.nvim_set_keymap

local noremap = { noremap = true, silent = true }

-- map Esc to jj
map("i", "jj", "<Esc>", noremap)
map("n", "<Esc>", "<cmd>set hlsearch!<CR>", noremap)

-- Add leader shortcuts
map("n", "<space>fb", [[<cmd>lua require('telescope.builtin').buffers()<CR>]], noremap)

map(
    "n",
    "<space>sf",
    [[<cmd>lua require('telescope.builtin').find_files({previewer = false, hidden=true})<CR>]],
    noremap
)

map("n", "<space>sb", [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], noremap)

map("n", "<space>sh", [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], noremap)
map("n", "<space>sd", [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], noremap)
map("n", "<space>sp", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], noremap)

map("n", "<space>?", [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], noremap)
map("n", "<space>fB", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", noremap)

-- Trouble mappings
map("n", "<space>xx", "<cmd>Trouble<cr>", noremap)
map("n", "<space>xw", "<cmd>Trouble workspace_diagnostics<cr>", noremap)
map("n", "<space>xd", "<cmd>Trouble document_diagnostics<cr>", noremap)
map("n", "<space>xl", "<cmd>Trouble loclist<cr>", noremap)
map("n", "<space>xq", "<cmd>Trouble quickfix<cr>", noremap)
map("n", "gR", "<cmd>Trouble lsp_references<cr>", noremap)
