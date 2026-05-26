local suppressMaximizeRule = hl.window_rule({
    match = { class = ".*" },

    suppress_event = "maximize",
})


hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})




hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})


hl.window_rule({match = {class = "org.gnome.Nautilus"}, float = true})
hl.window_rule({match = {class = "xdg-desktop-portal-gtk"}, float = true})
hl.window_rule({match = {class = "be.alexandervanhee.gradia"}, float = true})
hl.window_rule({match = {class = "org.pulseaudio.pavucontrol"}, float = true})
hl.layer_rule({match = {namespace = "^(rofi)$"}, blur = true, ignore_alpha = 0.2})
hl.layer_rule({match = {namespace = "^(swaync-notification-window)$"}, blur = true, ignore_alpha = 0.4, xray = false, animation = "slide right"})
hl.layer_rule({match = {namespace = "^(swaync-control-center)$"}, blur = true, ignore_alpha = 0.4, xray = false, animation = "slide right"})
