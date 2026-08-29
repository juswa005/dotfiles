import QtQuick
import "../../components"
import "../../theme"
import "../../services"
import Quickshell.Io

GlassCard {
    id: root
    implicitWidth: layout.implicitWidth + (Theme.padding * 4)
    implicitHeight: layout.implicitHeight + (Theme.padding * 2)

    Row {
        id: layout
        anchors.centerIn: parent
        spacing: 6

        Repeater {
            // Display static 10 workspaces or dynamic?
            // Let's display 1 to 5 always, plus any open workspaces > 5
            model: {
                let maxWs = 5;
                for (let i = 0; i < Hyprland.workspaces.length; i++) {
                    if (Hyprland.workspaces[i].id > maxWs) {
                        maxWs = Hyprland.workspaces[i].id;
                    }
                }
                return maxWs;
            }

            Rectangle {
                property int wsId: index + 1
                property bool isActive: Hyprland.activeWorkspaceId === wsId
                property bool hasWindows: {
                    for (let i = 0; i < Hyprland.workspaces.length; i++) {
                        if (Hyprland.workspaces[i].id === wsId && Hyprland.workspaces[i].windows > 0)
                            return true;
                    }
                    return false;
                }

                width: isActive ? 24 : 12
                height: 12
                radius: 6
                
                color: isActive ? Theme.colors.accent : (hasWindows ? Theme.colors.text : Theme.colors.textMuted)
                opacity: isActive ? 1.0 : (hasWindows ? 0.8 : 0.3)
                
                Behavior on width { NumberAnimation { duration: Theme.animationDuration; easing.type: Easing.OutQuart } }
                Behavior on color { ColorAnimation { duration: Theme.animationDuration } }
                Behavior on opacity { NumberAnimation { duration: Theme.animationDuration } }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        let p = Qt.createQmlObject('import Quickshell.Io; Process { command: ["hyprctl", "dispatch", "workspace", "' + wsId + '"]; running: true }', root);
                    }
                }
            }
        }
    }
}
