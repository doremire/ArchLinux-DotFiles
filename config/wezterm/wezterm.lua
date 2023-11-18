local wezterm = require("wezterm")

return {

    -- default_prog = {"neofetch"},
    -- timeout_milliseconds defaults to 1000 and can be omitted
    leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
    keys = {
        {
            key = '|',
            mods = 'LEADER|SHIFT',
            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
        {
            key = '-',
            mods = 'LEADER|CTRL',
            action = wezterm.action.SendString '\x01',
        },
    },
    -- sound
    audible_bell = "Disabled",
    -- font
    font_size = 12.0,
    font = wezterm.font_with_fallback {
        {
            family = "JetBrainsMono Nerd Font"
        },
        {
            family = "Symbols Nerd Font"
        },
        {
            family = "NotoSansCJKjp-Regular"
        },
    },
    -- color
    color_scheme = "tokyonight_night",
    -- padding
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0
    },
    -- tab bar
    use_fancy_tab_bar = false,
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = false,
    tab_max_width = 36,
    -- General
    custom_block_glyphs = true,
    -- automatically_reload_config = true,
    -- inactive_pane_hsb = {saturation = 1.0, brightness = 1.0},
    window_background_opacity = 0.5,
    -- window_close_confirmation = "NeverPrompt"

    default_cursor_style = 'BlinkingBlock',
    cursor_blink_rate = 400,
    force_reverse_video_cursor = true

}
