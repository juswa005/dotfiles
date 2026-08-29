import QtQuick
import "../../components"
import "../../theme"
import Quickshell.Services.SystemTray

GlassCard {
    id: root
    implicitWidth: layout.implicitWidth + (Theme.padding * 4)
    implicitHeight: layout.implicitHeight + (Theme.padding * 2)
    
    // Hide if empty
    visible: SystemTray.items.length > 0

    Row {
        id: layout
        anchors.centerIn: parent
        spacing: 8

        Repeater {
            model: SystemTray.items

            Image {
                source: modelData.icon
                width: 16
                height: 16
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: mouse => {
                        if (mouse.button === Qt.LeftButton) {
                            modelData.activate()
                        } else if (mouse.button === Qt.RightButton) {
                            modelData.contextMenu()
                        }
                    }
                }
            }
        }
    }
}
