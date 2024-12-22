-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Batman'
config.color_scheme = 'Dracula'
config.font = wezterm.font 'Anonymice Nerd Font Mono'
config.font_size = 12.0

-- Spawn a PowerShell in login mode
config.default_prog = { 'pwsh' }
-- config.default_prog = { 'bash' }
-- config.enable_wayland = false

-- and finally, return the configuration to wezterm
return config

