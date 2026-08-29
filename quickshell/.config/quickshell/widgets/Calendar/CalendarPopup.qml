import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../components"
import "../../theme"

PopupWindow {
    id: root
    
    implicitWidth: 300
    implicitHeight: 320
    
    color: "transparent"
    
    Rectangle {
        anchors.fill: parent
        anchors.margins: Theme.spacing
        color: Theme.colors.background
        radius: Theme.borderRadius
        border.color: Theme.colors.surfaceHover
        border.width: 1
        
        Column {
            anchors.fill: parent
            anchors.margins: Theme.padding * 2
            spacing: Theme.spacing
            
            Text {
                text: "Calendar"
                color: Theme.colors.text
                font: Theme.typography.heading
            }
            
            // Placeholder for a real calendar grid component
            Rectangle {
                width: parent.width
                height: 200
                color: Theme.colors.surface
                radius: Theme.borderRadius
                
                Text {
                    anchors.centerIn: parent
                    text: "(Monthly Grid Placeholder)"
                    color: Theme.colors.textMuted
                    font: Theme.typography.body
                }
            }
            
            Text {
                text: "Upcoming Events"
                color: Theme.colors.accent
                font: Theme.typography.bold
            }
            
            Text {
                text: "No events today."
                color: Theme.colors.textMuted
                font: Theme.typography.small
            }
        }
    }
}
