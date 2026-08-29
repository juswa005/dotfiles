pragma Singleton
import QtQuick

QtObject {
    readonly property color background: "#bf151515" // rgba(21, 21, 21, 0.75)
    readonly property color surface: "#cc2b2b2b" // rgba(43, 43, 43, 0.8)
    readonly property color surfaceHover: "#ff3a3a3a"
    readonly property color text: "#e0e0e0"
    readonly property color textMuted: "#a0a0a0"
    readonly property color accent: "#89b4fa" // Blue
    readonly property color critical: "#ff5555" // Red
    readonly property color warning: "#f0c674" // Yellow
    readonly property color success: "#a6e3a1" // Green

    // Transparencies
    readonly property color transparent: "transparent"
}
