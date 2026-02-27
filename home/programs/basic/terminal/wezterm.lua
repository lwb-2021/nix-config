local wezterm = require "wezterm"
local act = wezterm.action
local config = wezterm.config_builder()

config.unix_domains = {
  {
    name = "unix",
  },
}
config.default_gui_startup_args = { "connect", "unix" }
config.default_prog = { "fish" }
config.keys = {

}
return config
