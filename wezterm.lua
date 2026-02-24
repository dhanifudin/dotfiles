-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local launch_menu = {}
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	--- Set Pwsh as the default on Windows
	config.default_prog = { "pwsh.exe", "-NoLogo" }

	table.insert(launch_menu, {
		label = "Pwsh",
		args = { "pwsh.exe", "-NoLogo" },
	})
end

-- This is where you actually apply your config choices

config.font = wezterm.font("Fira Code")
config.font_size = 12
config.use_fancy_tab_bar = false
config.use_ime = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.window_decorations = "RESIZE"
config.launch_menu = launch_menu

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

wezterm.on("window-config-reloaded", function(window)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = scheme_for_appearance(appearance)
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)

-- and finally, return the configuration to wezterm
return config
