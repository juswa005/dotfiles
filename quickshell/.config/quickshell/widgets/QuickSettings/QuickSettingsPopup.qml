import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../../components"
import "../../theme"
import "../../services"

PopupWindow {
    id: root
    
    implicitWidth: 320
    implicitHeight: layout.implicitHeight + (Theme.spacing * 4)
    color: "transparent"
    
    GlassCard {
        anchors.fill: parent
        anchors.margins: Theme.spacing
        radius: Theme.borderRadius * 1.5

        Column {
            id: layout
            anchors.fill: parent
            anchors.margins: Theme.spacing * 2
            spacing: Theme.spacing * 2
            
            // User Header
            Row {
                width: parent.width
                spacing: Theme.spacing
                
                // Avatar placeholder
                Rectangle {
                    width: 48
                    height: 48
                    radius: 24
                    color: Theme.colors.accent
                    
                    Text {
                        anchors.centerIn: parent
                        text: "󰣇" // NixOS icon
                        font: Theme.typography.icon
                        color: Theme.colors.background
                    }
                }
                
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    
                    Text {
                        text: "Amiel"
                        font: Theme.typography.heading
                        color: Theme.colors.text
                    }
                    Text {
                        text: "NixOS + Hyprland"
                        font: Theme.typography.small
                        color: Theme.colors.textMuted
                    }
                }
            }
            
            // Sliders
            Column {
                width: parent.width
                spacing: Theme.spacing
                
                Row {
                    width: parent.width
                    spacing: Theme.spacing
                    
                    Text {
                        text: AudioService.muted ? "󰖁" : "󰕾"
                        font: Theme.typography.icon
                        color: Theme.colors.text
                        width: 24
                        horizontalAlignment: Text.AlignHCenter
                        
                        MouseArea {
                            anchors.fill: parent
                            onClicked: AudioService.toggleMute()
                        }
                    }
                    
                    CustomSlider {
                        width: parent.width - 32 - Theme.spacing
                        value: AudioService.volume
                        onMoved: (val) => AudioService.setVolume(val)
                    }
                }
                
                Row {
                    width: parent.width
                    spacing: Theme.spacing
                    
                    Text {
                        text: "󰃠"
                        font: Theme.typography.icon
                        color: Theme.colors.text
                        width: 24
                        horizontalAlignment: Text.AlignHCenter
                    }
                    
                    CustomSlider {
                        width: parent.width - 32 - Theme.spacing
                        value: BrightnessService.brightness
                        onMoved: (val) => BrightnessService.setBrightness(val)
                    }
                }
            }
            
            // Toggles
            Row {
                width: parent.width
                spacing: Theme.spacing
                
                // Wifi
                Rectangle {
                    width: (parent.width - Theme.spacing) / 2
                    height: 50
                    radius: Theme.borderRadius
                    color: Theme.colors.accent
                    
                    Row {
                        anchors.centerIn: parent
                        spacing: 8
                        Text { text: "󰤨"; font: Theme.typography.icon; color: Theme.colors.background }
                        Text { text: "Wi-Fi"; font: Theme.typography.bold; color: Theme.colors.background }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            // Dummy toggle
                        }
                    }
                }
                
                // Bluetooth
                Rectangle {
                    width: (parent.width - Theme.spacing) / 2
                    height: 50
                    radius: Theme.borderRadius
                    color: Theme.colors.surfaceHover
                    
                    Row {
                        anchors.centerIn: parent
                        spacing: 8
                        Text { text: "󰂯"; font: Theme.typography.icon; color: Theme.colors.text }
                        Text { text: "Bluetooth"; font: Theme.typography.bold; color: Theme.colors.text }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            // Dummy toggle
                        }
                    }
                }
            }
            
            // Divider
            Rectangle {
                width: parent.width
                height: 1
                color: Theme.colors.surfaceHover
            }
            
            // Power Menu
            Row {
                width: parent.width
                spacing: Theme.spacing
                
                // Shutdown
                Rectangle {
                    width: (parent.width - Theme.spacing * 3) / 4
                    height: 40
                    radius: Theme.borderRadius
                    color: Theme.colors.surfaceHover
                    
                    Text { anchors.centerIn: parent; text: "󰐥"; font: Theme.typography.icon; color: Theme.colors.critical }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = Theme.colors.critical
                        onExited: parent.color = Theme.colors.surfaceHover
                        onClicked: {
                            let p = Qt.createQmlObject(`import Quickshell.Io; Process { command: ["systemctl", "poweroff"] }`, root);
                            p.running = true;
                        }
                    }
                }
                
                // Reboot
                Rectangle {
                    width: (parent.width - Theme.spacing * 3) / 4
                    height: 40
                    radius: Theme.borderRadius
                    color: Theme.colors.surfaceHover
                    
                    Text { anchors.centerIn: parent; text: "󰜉"; font: Theme.typography.icon; color: Theme.colors.warning }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = Theme.colors.warning
                        onExited: parent.color = Theme.colors.surfaceHover
                        onClicked: {
                            let p = Qt.createQmlObject(`import Quickshell.Io; Process { command: ["systemctl", "reboot"] }`, root);
                            p.running = true;
                        }
                    }
                }
                
                // Suspend
                Rectangle {
                    width: (parent.width - Theme.spacing * 3) / 4
                    height: 40
                    radius: Theme.borderRadius
                    color: Theme.colors.surfaceHover
                    
                    Text { anchors.centerIn: parent; text: "󰤄"; font: Theme.typography.icon; color: Theme.colors.text }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = Theme.colors.accent
                        onExited: parent.color = Theme.colors.surfaceHover
                        onClicked: {
                            let p = Qt.createQmlObject(`import Quickshell.Io; Process { command: ["systemctl", "suspend"] }`, root);
                            p.running = true;
                        }
                    }
                }
                
                // Lock
                Rectangle {
                    width: (parent.width - Theme.spacing * 3) / 4
                    height: 40
                    radius: Theme.borderRadius
                    color: Theme.colors.surfaceHover
                    
                    Text { anchors.centerIn: parent; text: "󰌾"; font: Theme.typography.icon; color: Theme.colors.text }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = Theme.colors.accent
                        onExited: parent.color = Theme.colors.surfaceHover
                        onClicked: {
                            let p = Qt.createQmlObject(`import Quickshell.Io; Process { command: ["loginctl", "lock-session"] }`, root);
                            p.running = true;
                        }
                    }
                }
            }
        }
    }
}
