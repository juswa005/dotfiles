pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root
    
    property string temp: ""
    property string description: ""
    property string city: ""
    
    Component.onCompleted: updateWeather()
    
    function updateWeather() {
        weatherProcess.running = true
    }
    
    // Updates every hour
    property Timer weatherTimer: Timer {
        interval: 3600000
        running: true
        repeat: true
        onTriggered: updateWeather()
    }

    property Process weatherProcess: Process {
        command: ["curl", "-s", "wttr.in/?format=j1"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    let data = JSON.parse(this.text)
                    let current = data.current_condition[0]
                    root.temp = current.temp_C + "°C"
                    root.description = current.weatherDesc[0].value
                    root.city = data.nearest_area[0].areaName[0].value
                } catch(e) {}
            }
        }
    }
}
