local wezterm = require("wezterm")
local action = wezterm.action
local action_callback = wezterm.action_callback
local config = wezterm.config_builder()

config = {
    color_scheme = "Mariana",
    font = wezterm.font({ family = "Iosevka Nerd Font" }),
    font_size = 16,

    leader = {
        key = "q",
        mods = "CTRL",
        timeout_milliseconds = 2000,
    },

    window_padding = {
        left = 4,
        right = 4,
        top = 4,
        bottom = 4,
    },

    enable_tab_bar = true,
    tab_bar_at_bottom = true,
}

config.keys = {
    {
        key = "h",
        mods = "CTRL|ALT|SHIFT",
        action = action.ActivatePaneDirection("Left"),
    },
    {
        key = "l",
        mods = "CTRL|ALT|SHIFT",
        action = action.ActivatePaneDirection("Right"),
    },
    {
        key = "k",
        mods = "CTRL|ALT|SHIFT",
        action = action.ActivatePaneDirection("Up"),
    },
    {
        key = "j",
        mods = "CTRL|ALT|SHIFT",
        action = action.ActivatePaneDirection("Down"),
    },
    {
        key = "<",
        mods = "CTRL|ALT|SHIFT",
        action = action.SplitPane({
            direction = "Left",
            size = { Percent = 50 },
        }),
    },
    {
        key = ">",
        mods = "CTRL|ALT|SHIFT",
        action = action.SplitPane({
            direction = "Right",
            size = { Percent = 50 },
        }),
    },
    {
        key = "_",
        mods = "CTRL|ALT|SHIFT",
        action = action.SplitPane({
            direction = "Up",
            size = { Percent = 50 },
        }),
    },
    {
        key = "+",
        mods = "CTRL|ALT|SHIFT",
        action = action.SplitPane({
            direction = "Down",
            size = { Percent = 50 },
        }),
    },
    {
        key = "c",
        mods = "CTRL|ALT|SHIFT",
        action = action.SpawnTab("CurrentPaneDomain"),
    },

    {
        key = "b",
        mods = "CTRL|ALT|SHIFT",
        action = action.ActivateTabRelative(-1),
    },
    {
        key = "n",
        mods = "CTRL|ALT|SHIFT",
        action = action.ActivateTabRelative(1),
    },
    {
        key = "{",
        mods = "CTRL|ALT|SHIFT",
        action = action.ActivateTabRelative(-1),
    },
    {
        key = "}",
        mods = "CTRL|ALT|SHIFT",
        action = action.ActivateTabRelative(1),
    },

    {
        key = "d",
        mods = "CTRL|ALT|SHIFT",
        action = action.CloseCurrentPane({ confirm = true }),
    },
    {
        key = "x",
        mods = "CTRL|ALT|SHIFT",
        action = action.CloseCurrentTab({ confirm = true }),
    },
    {
        key = "w",
        mods = "CTRL|ALT|SHIFT",
        action = action.ShowTabNavigator,
    },
    {
        key = "m",
        mods = "CTRL|ALT|SHIFT",
        action = action.PromptInputLine({
            description = "Tab name",
            action = action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        }),
    },
}

for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "CTRL|ALT|SHIFT",
        action = action.ActivateTab(i - 1),
    })
end

return config
