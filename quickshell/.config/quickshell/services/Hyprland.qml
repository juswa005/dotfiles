pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root

    property var workspaces: []
    property int activeWorkspaceId: 1
    property string activeWindowTitle: ""
    property string activeWindowClass: ""

    Component.onCompleted: {
        updateWorkspaces()
        updateActiveWindow()
    }

    function updateWorkspaces() {
        workspacesProcess.running = true
    }

    function updateActiveWindow() {
        activeWindowProcess.running = true
    }

    // Fetches the workspace list
    property Process workspacesProcess: Process {
        command: ["hyprctl", "workspaces", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    let data = JSON.parse(this.text)
                    data.sort((a,b) => a.id - b.id)
                    root.workspaces = data
                } catch(e) {}
            }
        }
    }

    // Fetches the active window
    property Process activeWindowProcess: Process {
        command: ["hyprctl", "activewindow", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    if (this.text.trim() === "{}") {
                        root.activeWindowTitle = ""
                        root.activeWindowClass = ""
                        return
                    }
                    let data = JSON.parse(this.text)
                    root.activeWindowTitle = data.title
                    root.activeWindowClass = data.class
                } catch(e) {}
            }
        }
    }

    // Listens to Hyprland socket for events
    property Process socketListener: Process {
        command: ["sh", "-c", "socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                if (data.startsWith("workspace>>")) {
                    root.activeWorkspaceId = parseInt(data.split(">>")[1])
                    updateWorkspaces()
                } else if (data.startsWith("createworkspace>>") || data.startsWith("destroyworkspace>>")) {
                    updateWorkspaces()
                } else if (data.startsWith("activewindow>>") || data.startsWith("activewindowv2>>")) {
                    updateActiveWindow()
                } else if (data.startsWith("windowtitle>>")) {
                    updateActiveWindow()
                }
            }
        }
    }
}
