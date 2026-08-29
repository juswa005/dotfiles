pragma Singleton
import QtQuick

QtObject {
    readonly property QtObject colors: Colors
    readonly property QtObject typography: Typography

    readonly property int borderRadius: 8
    readonly property int padding: 6
    readonly property int spacing: 8
    readonly property int animationDuration: 250
}
