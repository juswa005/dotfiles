import QtQuick
import "../../components"
import "../../theme"
import "../../services"

GlassCard {
    id: root
    implicitWidth: layout.implicitWidth + (Theme.padding * 4)
    implicitHeight: layout.implicitHeight + (Theme.padding * 2)

    visible: Weather.temp !== ""

    Row {
        id: layout
        anchors.centerIn: parent
        spacing: 8

        Text {
            text: {
                let desc = Weather.description.toLowerCase()
                if (desc.includes("cloud") || desc.includes("overcast")) return "󰖐"
                if (desc.includes("rain") || desc.includes("drizzle")) return "󰖗"
                if (desc.includes("snow")) return "󰖘"
                if (desc.includes("thunder") || desc.includes("storm")) return "󰖓"
                return "󰖙"
            }
            color: Theme.colors.accent
            font: Theme.typography.icon
        }

        Text {
            text: Weather.temp + " • " + Weather.city
            color: Theme.colors.text
            font: Theme.typography.body
        }
    }
}
