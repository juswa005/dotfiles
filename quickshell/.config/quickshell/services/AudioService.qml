pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    
    property int volume: 50
    property bool muted: false

    Process {
        id: wpctlGet
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                let line = this.text;
                let parts = line.split(" ");
                if (parts.length >= 2) {
                    root.volume = Math.round(parseFloat(parts[1]) * 100);
                }
                root.muted = line.includes("[MUTED]");
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: wpctlGet.running = true
    }
    
    function setVolume(v) {
        // Optimistic UI update
        root.volume = v;
        let volStr = (v / 100.0).toFixed(2);
        let p = Qt.createQmlObject(`import Quickshell.Io; Process { command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "${volStr}"] }`, root);
        p.running = true;
    }
    
    function toggleMute() {
        let p = Qt.createQmlObject(`import Quickshell.Io; Process { command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"] }`, root);
        p.running = true;
        wpctlGet.running = true;
    }
}
