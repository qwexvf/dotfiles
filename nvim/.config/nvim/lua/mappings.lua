local map = vim.api.nvim_set_keymap

-- map Esc to jj
map('i', 'jj', '<Esc>', { noremap = true })

-- Add leader shortcuts
map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })

map(
  'n',
  '<leader>sf',
  [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
  { noremap = true, silent = true }
)

map(
  'n',
  '<leader>sb',
  [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
  { noremap = true, silent = true }
)

map('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
map('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
map('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
map('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
map(
  'n',
  '<leader>so',
  [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]],
  { noremap = true, silent = true }
)

map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })

-- Trouble mappings
map('n', '<leader>xx', '<cmd>Trouble<cr>', { silent = true, noremap = true })
map('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>', { silent = true, noremap = true })
map('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>', { silent = true, noremap = true })
map('n', '<leader>xl', '<cmd>Trouble loclist<cr>', { silent = true, noremap = true })
map('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', { silent = true, noremap = true })
map('n', 'gR', '<cmd>Trouble lsp_references<cr>', { silent = true, noremap = true })
