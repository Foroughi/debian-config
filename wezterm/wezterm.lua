local wezterm = require("wezterm")

local config = wezterm.config_builder()
-- This is where you actually apply your config choices

config.font = wezterm.font("CaskaydiaMono NF")
config.color_scheme = "Catppuccin Macchiato"
config.enable_tab_bar = false
config.line_height = 1.2
config.window_padding = {
	left = "7px",
	right = "7px",
	top = "7px",
	bottom = "7px",
}
config.key_tables = {}

return config
