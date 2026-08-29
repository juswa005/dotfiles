import QtQuick
import "../../components"
import "../../theme"
import "../../services"

GlassCard {
    id: root
    implicitWidth: Math.min(260, layout.implicitWidth + (Theme.padding * 4))
    implicitHeight: layout.implicitHeight + (Theme.padding * 2)

    visible: Mpris.status !== "Stopped" && Mpris.title !== ""

    Row {
        id: layout
        anchors.centerIn: parent
        spacing: 8

        // Album Art
        Rectangle {
            width: 24
            height: 24
            radius: 4
            color: "transparent"
            border.color: Theme.colors.surfaceHover
            border.width: 1
            clip: true
            
            Image {
                anchors.fill: parent
                source: Mpris.artUrl
                fillMode: Image.PreserveAspectCrop
                visible: source.toString() !== ""
            }
            
            Text {
                anchors.centerIn: parent
                text: "󰎆"
                color: Theme.colors.textMuted
                font: Theme.typography.icon
                visible: Mpris.artUrl === ""
            }
        }

        // Title and Artist
        Item {
            width: 140
            height: 24
            clip: true
            
            Column {
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                
                Text {
                    text: Mpris.title
                    color: Theme.colors.text
                    font: Theme.typography.bold
                    width: parent.width
                    elide: Text.ElideRight
                }
                Text {
                    text: Mpris.artist
                    color: Theme.colors.textMuted
                    font: Theme.typography.small
                    width: parent.width
                    elide: Text.ElideRight
                    visible: text !== ""
                }
            }
        }
        
        // Controls
        Row {
            spacing: 4
            anchors.verticalCenter: parent.verticalCenter
            
            Text {
                text: "󰒮" // Previous
                color: Theme.colors.text
                font: Theme.typography.icon
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Mpris.previous()
                }
            }
            
            Text {
                text: Mpris.status === "Playing" ? "󰏤" : "󰐊" // Pause / Play
                color: Theme.colors.text
                font: Theme.typography.icon
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Mpris.playPause()
                }
            }
            
            Text {
                text: "󰒭" // Next
                color: Theme.colors.text
                font: Theme.typography.icon
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Mpris.next()
                }
            }
        }
    }
}
