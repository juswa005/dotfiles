# Hyprland and NixOS Environment Context

This directory (`~/.config/hypr`) contains the configuration for a **Hyprland** Wayland compositor running on a **NixOS** system. 

## Key Environment Details:
1. **Operating System**: NixOS (Wayland environment, `NIXOS_OZONE_WL=1`).
2. **Configuration Language**: The primary Hyprland configuration is written in **Lua** (via a Lua wrapper/plugin for Hyprland), not the standard `hyprland.conf`. 
   - The entrypoint is `hyprland.lua`.
   - The config is modularized into `autostart.lua`, `env.lua`, `programs.lua`, `keybindings.lua`, `input.lua`, `look_and_feel.lua`, `monitors.lua`, `permissions.lua`, and `window_rules.lua`.
   - Any modifications to the core Hyprland rules/settings must be made in these Lua files.
3. **Other Configs**: Some ecosystem tools still use their standard config files:
   - `hypridle.conf`
   - `hyprlock.conf`
   - `hyprpaper.conf`
4. **Toolchain & Ecosystem**:
   - **Terminal**: `kitty`
   - **File Manager**: `nautilus`
   - **Launcher / Menu**: `wofi`
   - **Status Bar**: `waybar`
   - **Notifications**: `dunst`
   - **Wallpaper**: `swaybg`
   - **Night Light**: `hyprsunset`
   - **Polkit**: `hyprpolkitagent`
   - **Clipboard**: `wl-paste` + `cliphist`
5. **Theme**: Enforced Dark Theme (`Adwaita-dark`, `qt5ct`).

**Agent Instructions**:
When asked to modify the Hyprland configuration or perform desktop-related tasks in this directory, ALWAYS adhere to the Lua module structure. Do not create a standard `hyprland.conf` unless explicitly requested, and ensure changes respect the NixOS + Wayland ecosystem constraints.
