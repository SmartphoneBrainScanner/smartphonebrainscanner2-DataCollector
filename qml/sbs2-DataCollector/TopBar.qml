import QtQuick 2.0

Rectangle {
    color: "#ee2211"
    property alias helpButtonVisible: helpButton.visible
    property alias delegate: loader.sourceComponent
    signal helpTriggered
    signal quitTriggered
    Loader {
        id: loader
        height: parent.height
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: buttonArea.left
    }
    Row {
        anchors.right: parent.right
        id: buttonArea
        height: parent.height
        Button {
            color: pressed ? "#ee2211" : "#a6170b"
            height: parent.height
            width: height
            anchors.top: parent.top
            desc: "?"
            id: helpButton

            onClicked: {
                helpTriggered()
            }
        }
        Button {
            color: pressed ? "#ee2211" : "#a6170b"
            height: parent.height
            width: height
            anchors.top: parent.top
            desc: "X"

            onClicked: {
                quitTriggered()
            }
        }
    }
}
