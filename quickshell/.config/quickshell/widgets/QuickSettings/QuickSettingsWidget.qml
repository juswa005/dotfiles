import QtQuick
import Quickshell.Wayland
import "../../components"
import "../../theme"
import ".."

GlassCard {
    id: root

    property var panelWindow
    
    // Width can be dynamic or static. 
    // Usually it has 2-3 icons.
    implicitWidth: layout.implicitWidth + (Theme.padding * 4)
    implicitHeight: layout.implicitHeight + (Theme.padding * 2)

    clickable: true
    onClicked: popup.visible = !popup.visible

    QuickSettingsPopup {
        id: popup
        visible: false
        anchor {
            item: root
            edges: Edges.Bottom
            gravity: Edges.Bottom
        }
    }

    Row {
        id: layout
        anchors.centerIn: parent
        spacing: Theme.spacing

        Text {
            text: "󰤨" // Wifi icon
            font: Theme.typography.icon
            color: Theme.colors.text
        }

        Text {
            text: "󰂯" // Bluetooth icon
            font: Theme.typography.icon
            color: Theme.colors.text
        }
        
        Text {
            text: "󰕾" // Volume icon
            font: Theme.typography.icon
            color: Theme.colors.text
        }
    }
}
