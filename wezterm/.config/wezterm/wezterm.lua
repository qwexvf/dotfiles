local wezterm = require("wezterm")

return {
	enable_tab_bar = false,
	color_scheme = "Catppuccin Mocha",
	window_background_opacity = 0.98,
	font_rules = {
		{
			font = wezterm.font("Victor Mono", { weight = "Bold" }),
		},
	},
	font_size = 14.0,
	window_decorations = "None | RESIZE",
	default_cursor_style = "BlinkingBlock",
	use_ime = true,
}
