import QtQuick
import Quickshell
import "theme"
import "components"
import "widgets"
import "services"
import Quickshell.Services.Notifications

ShellRoot {
    Variants {
        model: Quickshell.screens

        Panel {
            id: mainPanel
            property var modelData
            screen: modelData
            
            leftContent: [
                WorkspaceWidget {},
                ActiveWindowWidget {}
            ]
            
            centerContent: [
                MusicWidget {},
                ClockWidget { panelWindow: mainPanel }
            ]
            
            rightContent: [
                NotificationWidget { panelWindow: mainPanel },
                QuickSettingsWidget { panelWindow: mainPanel },
                WeatherWidget {},
                SystemTrayWidget {}
            ]
        }
    }
    
    // Globally track notifications so they don't disappear
    Connections {
        target: NotificationServer
        
        function onNotification(notification) {
            notification.tracked = true;
        }
    }
}
