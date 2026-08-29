import QtQuick
import "../theme"

Rectangle {
    id: root

    property bool hovered: mouseArea.containsMouse
    property bool clickable: true
    signal clicked()

    color: hovered ? Theme.colors.surfaceHover : Theme.colors.surface
    radius: Theme.borderRadius
    
    // Smooth transition for hover
    Behavior on color {
        ColorAnimation { duration: Theme.animationDuration }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: root.clickable
        enabled: root.clickable
        onClicked: root.clicked()
    }
}
