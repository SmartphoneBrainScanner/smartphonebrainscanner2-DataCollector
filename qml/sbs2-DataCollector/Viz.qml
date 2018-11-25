import QtQuick 2.0

Item {
    property string username
    property string description
    property alias packageCount: currentPacketText.text

    property var topBarDelegate: Component {
        Column {
            Row {
                height: 48

                Text {
                    color: "white"
                    text: "Subject: "
                }
                Text {
                    color: "white"
                    text: username
                }
            }
            Row {
                height: 48

                Text {
                    color: "white"
                    text: "Session: "
                }
                Text {
                    color: "white"
                    text: description
                }
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
}
