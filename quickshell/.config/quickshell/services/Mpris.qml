pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root

    property string title: ""
    property string artist: ""
    property string status: "Stopped"
    property string artUrl: ""
    property real length: 0
    property real position: 0

    // Listens to metadata changes via playerctl
    property Process metadataListener: Process {
        command: ["playerctl", "metadata", "--follow", "--format", "{{ artist }}|{{ title }}|{{ status }}|{{ mpris:artUrl }}|{{ mpris:length }}"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                let parts = data.split("|")
                if (parts.length >= 5) {
                    root.artist = parts[0]
                    root.title = parts[1]
                    root.status = parts[2]
                    
                    let url = parts[3]
                    if (url.startsWith("file://")) {
                        // Keep as is for QML Image
                        root.artUrl = url
                    } else if (url.startsWith("http")) {
                        root.artUrl = url
                    } else {
                        root.artUrl = ""
                    }
                    
                    // length is in microseconds
                    let len = parseInt(parts[4])
                    if (!isNaN(len)) {
                        root.length = len / 1000000.0
                    } else {
                        root.length = 0
                    }
                    
                    // Fetch accurate position immediately
                    positionFetcher.running = true
                }
            }
        }
    }

    // Fetches the exact position
    property Process positionFetcher: Process {
        command: ["playerctl", "position"]
        stdout: StdioCollector {
            onStreamFinished: {
                let pos = parseFloat(this.text)
                if (!isNaN(pos)) {
                    root.position = pos
                }
            }
        }
    }

    // Timer to extrapolate position smoothly without shelling out every second
    property Timer positionTimer: Timer {
        interval: 1000
        running: root.status === "Playing"
        repeat: true
        onTriggered: {
            if (root.position < root.length) {
                root.position += 1.0
            }
        }
    }

    // Actions
    function playPause() {
        let p = Qt.createQmlObject('import Quickshell.Io; Process { command: ["playerctl", "play-pause"]; running: true }', root)
    }
    
    function next() {
        let p = Qt.createQmlObject('import Quickshell.Io; Process { command: ["playerctl", "next"]; running: true }', root)
    }
    
    function previous() {
        let p = Qt.createQmlObject('import Quickshell.Io; Process { command: ["playerctl", "previous"]; running: true }', root)
    }
}
