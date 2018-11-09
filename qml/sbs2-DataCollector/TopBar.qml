import QtQuick 2.0

Rectangle {
    color: "#ee2211"
    property alias delegate: loader.sourceComponent
    Loader {
        id: loader
        height: parent.height
        anchors.left: parent.left
    anchors.leftMargin: 10
        anchors.right: quitRect.left
    }
    Button {
        id: quitRect
            color: "#a6170b"
            height: parent.height
            width: height
            anchors.right: parent.right
            anchors.top: parent.top
            desc: "X"

            onClicked: {
                Qt.quit()
            }
        }
    
}
