import QtQuick 1.0

Rectangle {
    width: parent.width
    height: parent.height
    color: "black"

    function cqValue(name, value)
    {
	scalpmap.cqValue(name,value);
    }

    function currentPacket(value)
    {
	currentPacketText.text = value;
    }

    Text
    {
	id: usernameText
	font.pointSize: 32
	anchors.top: parent.top
	anchors.left: parent.left
	color: "white"
	text : setupScreen.username
    }
    Text
    {
	id: descText
	font.pointSize: 32
	anchors.top: usernameText.bottom
	anchors.left: parent.left
	color: "white"
	text : setupScreen.description
    }

    Text
    {
	id: currentPacketText
	font.pointSize: 72
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.top: parent.top
	anchors.topMargin: 220
	color: "white"
	text : "00"
    }

    Scalpmap{id: scalpmap; anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom}

    Rectangle
    {
	id: quitRect
	color: "red"
	height: 100
	width: 100
	anchors.right: parent.right
	anchors.top: parent.top

	MouseArea
	{
	    anchors.fill: parent
	    onClicked: {
		Qt.quit();
	    }
	}
    }

}
