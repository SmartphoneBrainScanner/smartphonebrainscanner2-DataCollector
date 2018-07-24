import QtQuick 2.2

FocusScope {
    property alias desc: text.text
    property bool isReady: true
    signal clicked
    id: button
    property alias color: rect.color
    property alias radius: rect.radius
    Rectangle {
        Keys.onReturnPressed: {
            button.clicked()
        }

        Keys.onEnterPressed: {
            button.clicked()
        }
        focus: true
        id: rect
        anchors.fill: parent
        color: "#ee2211"
        opacity: isReady ? 1 : 0.4

        Text {
            id: text
            color: "#eee"
            anchors.centerIn: parent
            font.bold: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: button.clicked()
        }
    }
}
