-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
--
-- config.color_scheme = 'Astrodark (Gogh)'
config.color_scheme = 'Chalk (dark) (terminal.sexy)'

config.disable_default_key_bindings = true

-- config.leader = { key = 'VoidSymbol', mods = '', timeout_milliseconds = math.maxinteger }
-- config.leader = { key = 'a', mods = 'ALT', timeout_milliseconds = math.maxinteger }
config.keys = {
  {
    key = '\\',
    mods = 'ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'ALT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'h',
    mods = 'CTRL|ALT',
    action = wezterm.action.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'j',
    mods = 'CTRL|ALT',
    action = wezterm.action.AdjustPaneSize { 'Down', 5 },
  },
  { key = 'k',
    mods = 'CTRL|ALT',
    action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
  {
    key = 'l',
    mods = 'CTRL|ALT',
    action = wezterm.action.AdjustPaneSize { 'Right', 5 },
  },
  {
    key = 't',
    mods = 'ALT',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'p',
    mods = 'ALT',
    action = wezterm.action.PaneSelect {
      alphabet = '1234567890',
    },
  },
  {
    key = 'h',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'w',
    mods = 'CTRL',
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
  { key = 'L',
    mods = 'CTRL',
    action = wezterm.action.ShowDebugOverlay
  },
}

-- Create keybinds to move to tabs using ALT + 1-9
for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- config.default_prog = { '/usr/local/bin/pwsh' }
config.default_prog = { 'pwsh' }

-- Writes to the log use Ctrl+Shift+L to access debug menu
-- wezterm.log_info(font_handle)

-- local font_size = os.execute("")
-- config.font_size = tonumber(font_handle)

function getOS()
	-- ask LuaJIT first
	-- if jit then
	-- 	return jit.os
	-- end
	--
	-- Unix, Linux variants
	local fh,err = assert(io.popen("uname -o 2>/dev/null","r"))
	if fh then
		osname = fh:read()
	end
	--
	return osname or "Windows"
end

wezterm.log_info(getOS())

if (osname == "Darwin")
then
  config.font_size = 14.0
else
  config.font_size = 11.0
end

config.font = wezterm.font 'AnonymicePro Nerd Font Mono'

config.enable_tab_bar = false

config.window_padding = {
    left = 0,
    right = 0,
    bottom = 0,
    top = 0,
}

config.window_background_opacity = 0.90

-- config.background = {
--   {
--   opacity = "0.5",
--   },
-- }

config.initial_cols = 500
config.initial_rows = 500

-- and finally, return the configuration to wezterm
return config

