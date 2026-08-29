import QtQuick
import "../../components"
import "../../theme"
import "../../services"

GlassCard {
    id: root
    implicitWidth: Math.min(300, layout.implicitWidth + (Theme.padding * 4))
    implicitHeight: layout.implicitHeight + (Theme.padding * 2)
    
    // Hide if no window
    visible: Hyprland.activeWindowTitle !== ""

    Row {
        id: layout
        anchors.centerIn: parent
        spacing: 8

        Text {
            text: Hyprland.activeWindowClass
            color: Theme.colors.accent
            font: Theme.typography.bold
            visible: text !== ""
        }

        Text {
            text: "—"
            color: Theme.colors.textMuted
            font: Theme.typography.small
            visible: Hyprland.activeWindowClass !== "" && Hyprland.activeWindowTitle !== ""
        }

        Text {
            text: Hyprland.activeWindowTitle
            color: Theme.colors.text
            font: Theme.typography.body
            elide: Text.ElideRight
            width: Math.min(implicitWidth, 200) // Truncate long titles
        }
    }
}
