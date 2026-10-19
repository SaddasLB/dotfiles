
--------------------
--- KEYBINDINGSS ---
---  ~ LAPTOP ~  ---
--------------------

-- Volume Control
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd([[
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-;
    pw-play ~/Documents/select.mp3 &
    exec notify-send -e -t 1000 \
        -h string:x-canonical-private-synchronous:audio \
        "$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
]]), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd([[
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+;
    pw-play ~/Documents/select.mp3 &
    exec notify-send -e -t 1000 \
        -h string:x-canonical-private-synchronous:audio \
        "$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
]]), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(
    "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
), { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

-- Brightness control
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd([[
    brightnessctl s +5% &&
    exec notify-send -e -t 1000 \
        -h string:x-canonical-private-synchronous:brightness \
        "Brightness: $(brightnessctl get)"
]]), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd([[
    brightnessctl s 5%- &&
    exec notify-send -e -t 1000 \
        -h string:x-canonical-private-synchronous:brightness \
        "Brightness: $(brightnessctl get)"
]]), { locked = true, repeating = true })
