pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    
    property int brightness: 50

    Process {
        id: brightGet
        command: ["brightnessctl", "-m"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                let line = this.text;
                let parts = line.split(",");
                if (parts.length >= 4) {
                    root.brightness = parseInt(parts[3]);
                }
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: brightGet.running = true
    }
    
    function setBrightness(v) {
        root.brightness = v;
        let p = Qt.createQmlObject(`import Quickshell.Io; Process { command: ["brightnessctl", "set", "${v}%"] }`, root);
        p.running = true;
    }
}
