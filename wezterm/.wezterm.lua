local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Colors (Moonfly theme matching Alacritty)
config.colors = {
  foreground = '#bdbdbd',
  background = '#080808',
  cursor_bg = '#8e8e8e',
  cursor_fg = '#080808',
  cursor_border = '#8e8e8e',
  selection_fg = '#080808',
  selection_bg = '#b2ceee',
  
  ansi = {
    '#323437', '#ff5d5d', '#8cc85f', '#e3c78a',
    '#80a0ff', '#cf87e8', '#79dac8', '#c6c6c6',
  },
  brights = {
    '#949494', '#ff5189', '#36c692', '#c6c684',
    '#74b2ff', '#ae81ff', '#85dc85', '#e4e4e4',
  },
}

-- Font (matching Alacritty size)
config.font = wezterm.font 'ZedMono Nerd Font'
config.font_size = 12

-- Window (matching Alacritty settings)
config.window_decorations = 'NONE'
config.window_padding = { left = 5, right = 5, top = 5, bottom = 5 }

-- Disable all extra features for simplicity
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = 'NeverPrompt'
config.audible_bell = 'Disabled'
config.visual_bell = { fade_in_function = 'EaseIn', fade_in_duration_ms = 0 }

return config