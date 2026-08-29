import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import "../../components"
import "../../theme"

PopupWindow {
    id: root
    
    implicitWidth: 350
    implicitHeight: 500
    color: "transparent"
    
    GlassCard {
        anchors.fill: parent
        anchors.margins: Theme.spacing
        radius: Theme.borderRadius * 1.5

        Column {
            anchors.fill: parent
            anchors.margins: Theme.spacing * 2
            spacing: Theme.spacing
            
            // Header
            Row {
                width: parent.width
                
                Text {
                    text: "Notifications"
                    font: Theme.typography.heading
                    color: Theme.colors.text
                }
                
                Item { width: 1; height: 1; Layout.fillWidth: true }
                
                Text {
                    text: "Clear All"
                    font: Theme.typography.body
                    color: Theme.colors.textMuted
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            // Dismiss all tracked notifications
                            let notifs = NotificationServer.trackedNotifications;
                            for (let i = 0; i < notifs.count; i++) {
                                notifs.at(i).dismiss();
                            }
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
            
            // Notification List
            ListView {
                id: listView
                width: parent.width
                height: parent.height - y
                clip: true
                spacing: Theme.spacing
                
                model: NotificationServer.trackedNotifications
                
                delegate: GlassCard {
                    width: listView.width
                    implicitHeight: contentCol.implicitHeight + Theme.spacing * 2
                    color: Theme.colors.surfaceHover
                    
                    Column {
                        id: contentCol
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: Theme.spacing
                        spacing: 4
                        
                        // Header: App name and Close button
                        Row {
                            width: parent.width
                            
                            Text {
                                text: modelData.appName
                                font: Theme.typography.small
                                color: Theme.colors.textMuted
                                elide: Text.ElideRight
                                width: parent.width - 20
                            }
                            
                            Text {
                                text: "󰅖" // Close icon
                                font: Theme.typography.icon
                                color: Theme.colors.textMuted
                                
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: modelData.dismiss()
                                }
                            }
                        }
                        
                        // Summary
                        Text {
                            width: parent.width
                            text: modelData.summary
                            font: Theme.typography.bold
                            color: Theme.colors.text
                            wrapMode: Text.Wrap
                        }
                        
                        // Body
                        Text {
                            width: parent.width
                            text: modelData.body
                            font: Theme.typography.body
                            color: Theme.colors.textMuted
                            wrapMode: Text.Wrap
                        }
                        
                        // Actions
                        Row {
                            width: parent.width
                            spacing: Theme.spacing
                            
                            Repeater {
                                model: modelData.actions
                                delegate: Rectangle {
                                    color: actionMouse.containsMouse ? Theme.colors.accent : Theme.colors.surface
                                    radius: Theme.borderRadius / 2
                                    width: actionText.implicitWidth + 20
                                    height: actionText.implicitHeight + 10
                                    
                                    Text {
                                        id: actionText
                                        anchors.centerIn: parent
                                        text: modelData.text
                                        color: Theme.colors.text
                                        font: Theme.typography.small
                                    }
                                    
                                    MouseArea {
                                        id: actionMouse
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: modelData.invoke()
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Empty state
                Text {
                    anchors.centerIn: parent
                    visible: listView.count === 0
                    text: "No new notifications"
                    font: Theme.typography.body
                    color: Theme.colors.textMuted
                }
            }
        }
    }
}
