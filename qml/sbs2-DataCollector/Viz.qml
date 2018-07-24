import QtQuick 2.0

Rectangle {
    width: parent.width
    height: parent.height
    color: "#f9bcb7"

    function cqValue(name, value) {
        scalpmap.cqValue(name, value)
    }

    function currentPacket(value) {
        currentPacketText.text = value
    }

    Rectangle {
        color: "#ee2211"
        width: parent.width
        height: 120

        Rectangle {
            id: usernameBox
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.topMargin: 12
            height: 48

            Text {
                anchors.left: parent.left
                id: usernameLabel
                color: "white"
                text: "Subject: "
            }
            Text {
                id: usernameText
                anchors.left: usernameLabel.right
                color: "white"
                text: setupScreen.username
            }
        }
        Rectangle {
            anchors.top: usernameBox.bottom
            anchors.left: parent.left
            anchors.leftMargin: 24
            height: 48

            Text {
                id: descriptionLabel
                anchors.left: parent.left
                color: "white"
                text: "Session: "
            }
            Text {
                id: descText
                anchors.left: descriptionLabel.right
                color: "white"
                text: setupScreen.description
            }
        }

        Button {
            id: quitRect
            color: "#a6170b"
            height: parent.height
            width: 240
            anchors.right: parent.right
            anchors.top: parent.top
            desc: "Save & Quit"

            onClicked: {
                Qt.quit()
            }
        }
    }

    Text {
        id: currentPacketLabel
        font.pointSize: 28
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 300
        color: "#a6170b"
        text: "Number of collected packages"
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        horizontalAlignment: Text.AlignHCenter
    }
    Text {
        id: currentPacketText
        font.pointSize: 72
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: currentPacketLabel.bottom
        anchors.topMargin: 24
        color: "#a6170b"
        text: "00"
    }

    Scalpmap {
        id: scalpmap
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
    }
}
