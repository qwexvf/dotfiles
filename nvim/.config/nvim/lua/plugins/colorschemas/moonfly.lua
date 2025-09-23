return {
  "bluz71/vim-moonfly-colors",
  name = "moonfly",
  lazy = false,
  priority = 1000,
  config = function()
    -- Configure moonfly options before setting colorscheme
    vim.g.moonflyCursorColor = true
    vim.g.moonflyItalics = true
    vim.g.moonflyNormalFloat = true
    vim.g.moonflyTerminalColors = true
    vim.g.moonflyTransparent = false
    vim.g.moonflyUndercurls = true
    vim.g.moonflyUnderlineMatchParen = true
    vim.g.moonflyVirtualTextColor = true
    
    -- Set the colorscheme
    vim.cmd.colorscheme "moonfly"
  end,
}
