import QtQuick
import "../theme"

Item {
    id: root
    
    property int value: 50
    property int from: 0
    property int to: 100
    property color activeColor: Theme.colors.accent
    property color backgroundColor: Theme.colors.surface
    
    signal moved(int newValue)
    
    implicitWidth: 200
    implicitHeight: 24
    
    Rectangle {
        id: track
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        height: 8
        radius: height / 2
        color: root.backgroundColor
        
        Rectangle {
            id: fill
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: track.width * ((root.value - root.from) / (root.to - root.from))
            radius: parent.radius
            color: root.activeColor
            
            Behavior on width {
                NumberAnimation {
                    duration: mouseArea.pressed ? 0 : 150
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
    
    Rectangle {
        id: handle
        width: 16
        height: 16
        radius: 8
        color: "#ffffff"
        anchors.verticalCenter: track.verticalCenter
        x: fill.width - (width / 2)
        
        Behavior on x {
            NumberAnimation {
                duration: mouseArea.pressed ? 0 : 150
                easing.type: Easing.OutCubic
            }
        }
        
        // Add a subtle shadow/glow to the handle
        Rectangle {
            anchors.centerIn: parent
            width: parent.width + 4
            height: parent.height + 4
            radius: width / 2
            color: root.activeColor
            opacity: mouseArea.pressed ? 0.3 : (mouseArea.containsMouse ? 0.2 : 0)
            z: -1
            
            Behavior on opacity {
                NumberAnimation { duration: 150 }
            }
        }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        
        function updateValueFromMouse(mouseX) {
            let p = Math.max(0, Math.min(1, mouseX / track.width));
            let val = Math.round(root.from + p * (root.to - root.from));
            if (val !== root.value) {
                root.value = val;
                root.moved(val);
            }
        }
        
        onPositionChanged: {
            if (pressed) {
                updateValueFromMouse(mouseX);
            }
        }
        
        onPressed: {
            updateValueFromMouse(mouseX);
        }
    }
}
