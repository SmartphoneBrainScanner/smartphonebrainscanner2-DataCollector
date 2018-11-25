import QtQuick 2.2

FocusScope {
    id: input
    x: 100
    y: 100
    property alias desc: header.text
    property alias text: textInput.text
    width: 360
    height: 150

    Rectangle {
        height: parent.height / 5 * 2
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#ee2211"
        border.color: "#a6170b"
        Text {
            id: header
            color: "#eee"
            anchors.centerIn: parent
        }
    }

    Rectangle {

        height: parent.height / 5 * 3
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#fbd2cf"
        border.color: "#a6170b"

        TextInput {
            id: textInput
            color: "#a6170b"
            font.bold: true

            focus: true
            smooth: true
            anchors.fill: parent
            anchors.leftMargin: 24
            anchors.topMargin: 12
        }
    }
}
