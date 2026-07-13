#!/usr/bin/env bash

# Configuration files
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
AUTOSTART_LUA="$HOME/.config/hypr/autostart.lua"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"
KITTY_CONF="$HOME/.config/kitty/kitty.conf"
WAYBAR_STYLE="$HOME/.config/waybar/style.css"
GTK3_SETTINGS="$HOME/.config/gtk-3.0/settings.ini"
GTK4_SETTINGS="$HOME/.config/gtk-4.0/settings.ini"
XSETTINGSD_CONF="$HOME/.config/xsettingsd/xsettingsd.conf"
WOFI_STYLE="$HOME/.config/wofi/style.css"

# Determine current mode by checking autostart.lua config (fallback to hyprpaper)
if grep -q "wallp-light.png" "$AUTOSTART_LUA" || grep -q "wallp-light.png" "$HYPRPAPER_CONF" 2>/dev/null; then
    MODE="dark"
else
    MODE="light"
fi

if [ "$MODE" = "light" ]; then
    echo "Switching to light mode..."
    
    # 1. Wallpaper
    [ -f "$HYPRPAPER_CONF" ] && sed -i 's/wallp\.jpg/wallp-light.png/g' "$HYPRPAPER_CONF"
    [ -f "$AUTOSTART_LUA" ] && sed -i 's/wallp\.jpg/wallp-light.png/g' "$AUTOSTART_LUA"
    
    # 2. Hyprlock
    sed -i 's/wallp\.jpg/wallp-light.png/g' "$HYPRLOCK_CONF"
    sed -i 's/rgba(255, 255, 255, 1)/rgba(20, 20, 20, 1)/g' "$HYPRLOCK_CONF"
    sed -i 's/rgba(242, 243, 244, 0.75)/rgba(15, 15, 15, 0.75)/g' "$HYPRLOCK_CONF"
    sed -i 's/##cdd6f4/##4c4f69/g' "$HYPRLOCK_CONF"
    
    # 3. Kitty
    ln -sf "$HOME/.config/kitty/theme-light.conf" "$HOME/.config/kitty/theme.conf"
    
    # 4. Waybar
    sed -i 's/rgba(21, 21, 21, 0.75)/rgba(250, 250, 250, 0.75)/g' "$WAYBAR_STYLE"
    sed -i 's/rgba(43, 43, 43, 0.8)/rgba(200, 200, 200, 0.8)/g' "$WAYBAR_STYLE"
    sed -i 's/color: #e0e0e0;/color: #1a1a1a;/g' "$WAYBAR_STYLE"
    sed -i 's/color: #ffffff;/color: #0f0f0f;/g' "$WAYBAR_STYLE"
    sed -i 's/color: #dddddd;/color: #333333;/g' "$WAYBAR_STYLE"
    
    # 5. GTK Settings & dconf (Nautilus)
    [ -f "$GTK3_SETTINGS" ] && sed -i 's/gtk-application-prefer-dark-theme=true/gtk-application-prefer-dark-theme=false/g' "$GTK3_SETTINGS"
    [ -f "$GTK3_SETTINGS" ] && sed -i 's/gtk-theme-name=Adwaita-dark/gtk-theme-name=Adwaita/g' "$GTK3_SETTINGS"
    [ -f "$GTK4_SETTINGS" ] && sed -i 's/gtk-application-prefer-dark-theme=true/gtk-application-prefer-dark-theme=false/g' "$GTK4_SETTINGS"
    [ -f "$GTK4_SETTINGS" ] && sed -i 's/gtk-theme-name=Adwaita-dark/gtk-theme-name=Adwaita/g' "$GTK4_SETTINGS"
    
    if command -v dconf &> /dev/null; then
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
        dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita'"
    fi
    
    # 6. xsettingsd
    [ -f "$XSETTINGSD_CONF" ] && sed -i 's/"Adwaita-dark"/"Adwaita"/g' "$XSETTINGSD_CONF"
    
    # 7. Wofi
    if [ -f "$WOFI_STYLE" ]; then
        sed -i 's/rgba(21, 21, 21, 0.75)/rgba(250, 250, 250, 0.75)/g' "$WOFI_STYLE"
        sed -i 's/rgba(43, 43, 43, 0.5)/rgba(200, 200, 200, 0.5)/g' "$WOFI_STYLE"
        sed -i 's/rgba(43, 43, 43, 0.8)/rgba(200, 200, 200, 0.8)/g' "$WOFI_STYLE"
        sed -i 's/#e0e0e0/#1a1a1a/g' "$WOFI_STYLE"
        sed -i 's/#2b2b2b/#c8c8c8/g' "$WOFI_STYLE"
    fi

else
    echo "Switching to dark mode..."
    
    # 1. Wallpaper
    [ -f "$HYPRPAPER_CONF" ] && sed -i 's/wallp-light\.png/wallp.jpg/g' "$HYPRPAPER_CONF"
    [ -f "$AUTOSTART_LUA" ] && sed -i 's/wallp-light\.png/wallp.jpg/g' "$AUTOSTART_LUA"
    
    # 2. Hyprlock
    sed -i 's/wallp-light\.png/wallp.jpg/g' "$HYPRLOCK_CONF"
    sed -i 's/rgba(20, 20, 20, 1)/rgba(255, 255, 255, 1)/g' "$HYPRLOCK_CONF"
    sed -i 's/rgba(15, 15, 15, 0.75)/rgba(242, 243, 244, 0.75)/g' "$HYPRLOCK_CONF"
    sed -i 's/##4c4f69/##cdd6f4/g' "$HYPRLOCK_CONF"
    
    # 3. Kitty
    ln -sf "$HOME/.config/kitty/theme-dark.conf" "$HOME/.config/kitty/theme.conf"
    
    # 4. Waybar
    sed -i 's/rgba(250, 250, 250, 0.75)/rgba(21, 21, 21, 0.75)/g' "$WAYBAR_STYLE"
    sed -i 's/rgba(200, 200, 200, 0.8)/rgba(43, 43, 43, 0.8)/g' "$WAYBAR_STYLE"
    sed -i 's/color: #1a1a1a;/color: #e0e0e0;/g' "$WAYBAR_STYLE"
    sed -i 's/color: #0f0f0f;/color: #ffffff;/g' "$WAYBAR_STYLE"
    sed -i 's/color: #333333;/color: #dddddd;/g' "$WAYBAR_STYLE"
    
    # 5. GTK Settings & dconf (Nautilus)
    [ -f "$GTK3_SETTINGS" ] && sed -i 's/gtk-application-prefer-dark-theme=false/gtk-application-prefer-dark-theme=true/g' "$GTK3_SETTINGS"
    [ -f "$GTK3_SETTINGS" ] && sed -i 's/gtk-theme-name=Adwaita/gtk-theme-name=Adwaita-dark/g' "$GTK3_SETTINGS"
    [ -f "$GTK4_SETTINGS" ] && sed -i 's/gtk-application-prefer-dark-theme=false/gtk-application-prefer-dark-theme=true/g' "$GTK4_SETTINGS"
    [ -f "$GTK4_SETTINGS" ] && sed -i 's/gtk-theme-name=Adwaita/gtk-theme-name=Adwaita-dark/g' "$GTK4_SETTINGS"

    if command -v dconf &> /dev/null; then
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
        dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita-dark'"
    fi
    
    # 6. xsettingsd
    [ -f "$XSETTINGSD_CONF" ] && sed -i 's/"Adwaita"/"Adwaita-dark"/g' "$XSETTINGSD_CONF"
    
    # 7. Wofi
    if [ -f "$WOFI_STYLE" ]; then
        sed -i 's/rgba(250, 250, 250, 0.75)/rgba(21, 21, 21, 0.75)/g' "$WOFI_STYLE"
        sed -i 's/rgba(200, 200, 200, 0.5)/rgba(43, 43, 43, 0.5)/g' "$WOFI_STYLE"
        sed -i 's/rgba(200, 200, 200, 0.8)/rgba(43, 43, 43, 0.8)/g' "$WOFI_STYLE"
        sed -i 's/#1a1a1a/#e0e0e0/g' "$WOFI_STYLE"
        sed -i 's/#c8c8c8/#2b2b2b/g' "$WOFI_STYLE"
    fi

fi

# Apply everything dynamically

# Reload swaybg or hyprpaper
pkill swaybg || true
if [ "$MODE" = "light" ]; then
    swaybg -i "$HOME/.config/hypr/wallpapers/wallp-light.png" -m fill &> /dev/null & disown
else
    swaybg -i "$HOME/.config/hypr/wallpapers/wallp.jpg" -m fill &> /dev/null & disown
fi

pkill hyprpaper || true

echo "Reloading kitty..."
pkill -SIGUSR1 kitty || true

echo "Reloading waybar..."
pkill waybar || true
waybar &> /dev/null & disown

echo "Reloading xsettingsd..."
pkill xsettingsd || true
xsettingsd &> /dev/null & disown

echo "Theme switched to $MODE successfully!"
