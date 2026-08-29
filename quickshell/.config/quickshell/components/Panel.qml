import QtQuick
import Quickshell
import Quickshell.Wayland
import "../theme"

PanelWindow {
    id: root

    property alias leftContent: leftContainer.children
    property alias centerContent: centerContainer.children
    property alias rightContent: rightContainer.children

    // Defaults for top bar
    anchors {
        top: true
        left: true
        right: true
    }
    
    // Reserve space for the panel so windows don't overlap it
    exclusionMode: ExclusionMode.Auto
    
    implicitHeight: 36 // 34-36px is standard Waybar height
    color: "transparent"

    // Optional blur behind the panel
    // WlrLayerSurface blur can be set if supported by compositors, but Quickshell can just use semi-transparent colors.
    // For Hyprland, we can use `layerrule = blur, quickshell` in hyprland config later.

    Rectangle {
        id: background
        anchors.fill: parent
        color: Theme.colors.background

        // We use RowLayout or anchoring to distribute the sections
        Item {
            id: container
            anchors.fill: parent
            anchors.leftMargin: Theme.spacing
            anchors.rightMargin: Theme.spacing

            Row {
                id: leftContainer
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: Theme.spacing
            }

            Row {
                id: centerContainer
                anchors.centerIn: parent
                spacing: Theme.spacing
            }

            Row {
                id: rightContainer
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                spacing: Theme.spacing
            }
        }
    }
}
