pragma Singleton
import QtQuick

QtObject {
    readonly property string mainFont: "JetBrainsMono Nerd Font"
    readonly property string iconFont: "Symbols Nerd Font"

    readonly property font body: Qt.font({
        family: mainFont,
        pixelSize: 13,
        weight: Font.Normal
    })

    readonly property font bold: Qt.font({
        family: mainFont,
        pixelSize: 13,
        weight: Font.Bold
    })

    readonly property font small: Qt.font({
        family: mainFont,
        pixelSize: 11,
        weight: Font.Normal
    })

    readonly property font heading: Qt.font({
        family: mainFont,
        pixelSize: 16,
        weight: Font.Bold
    })

    readonly property font icon: Qt.font({
        family: iconFont,
        pixelSize: 14,
        weight: Font.Normal
    })
}
