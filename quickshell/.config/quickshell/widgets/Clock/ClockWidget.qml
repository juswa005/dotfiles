import QtQuick
import Quickshell.Wayland
import "../../components"
import "../../theme"
import ".."

GlassCard {
    id: root
    implicitWidth: layout.implicitWidth + (Theme.padding * 4)
    implicitHeight: layout.implicitHeight + (Theme.padding * 2)

    property string timeString: ""
    property string dateString: ""

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            let date = new Date()
            
            // Format time: "12:34 PM"
            let hours = date.getHours()
            let ampm = hours >= 12 ? "PM" : "AM"
            hours = hours % 12
            hours = hours ? hours : 12
            let minutes = date.getMinutes()
            minutes = minutes < 10 ? "0" + minutes : minutes
            root.timeString = hours + ":" + minutes + " " + ampm

            // Format date: "Mon, Jan 1"
            let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            root.dateString = days[date.getDay()] + ", " + months[date.getMonth()] + " " + date.getDate()
        }
    }

    clickable: true
    onClicked: calendarPopup.visible = !calendarPopup.visible

    property var panelWindow

    CalendarPopup {
        id: calendarPopup
        visible: false
        anchor {
            item: root
            edges: Edges.Bottom
            gravity: Edges.Bottom
        }
    }

    Row {
        id: layout
        anchors.centerIn: parent
        spacing: 8

        Text {
            text: root.dateString
            color: Theme.colors.textMuted
            font: Theme.typography.body
        }

        Text {
            text: "•"
            color: Theme.colors.textMuted
            font: Theme.typography.small
        }

        Text {
            text: root.timeString
            color: Theme.colors.text
            font: Theme.typography.bold
        }
    }
}
