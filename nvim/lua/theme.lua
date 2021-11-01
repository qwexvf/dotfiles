local nightfox = require('nightfox')

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nightfox.setup({
  fox = 'nordfox', -- change the colorscheme to use nordfox
  styles = {
    comments = 'italic', -- change style of comments to be italic
    keywords = 'bold,italic', -- change style of keywords to be bold
    functions = 'bold', -- styles can be a comma separated list
    variables = 'bold'
  },
  colors = {
    red = '#FF000', -- Override the red color for MAX POWER
    bg_alt = '#000000'
  },
  hlgroups = {
    TSPunctDelimiter = {fg = '${red}'}, -- Override a highlight group with the color red
    LspCodeLens = {bg = '#000000', style = 'italic'}
  },
  inverse = {
    match_paren = false -- inverse the highlighting of match_parens
  }
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()
