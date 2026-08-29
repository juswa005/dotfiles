import QtQuick
import Quickshell.Wayland
import "../../components"
import "../../theme"
import ".."

GlassCard {
    id: root

    property var panelWindow

    implicitWidth: 30
    implicitHeight: 30
    
    clickable: true
    onClicked: center.visible = !center.visible

    NotificationCenter {
        id: center
        visible: false
        anchor {
            item: root
            edges: Edges.Bottom
            gravity: Edges.Bottom
        }
    }

    Text {
        anchors.centerIn: parent
        text: "󰂚" // Bell icon
        font: Theme.typography.icon
        color: Theme.colors.text
    }
}
