import QtQuick 1.0

Item
{

    x: 100
    y: 100
    property string desc
    property string text: ""
    property int fakeWidth: 380//260
    property int fakeHeight: 120//80
    opacity: 0.2

    width: 360
    height: 150

    Rectangle
    {
        width: parent.width
        height: parent.height/5*2
        color: "#ee2211"
        border.color: "#a6170b"
        Text
        {
            color: "#eee"
            font.pointSize: 28
            text: {return String(parent.parent.desc); }
            anchors.centerIn: parent
        }
        anchors.bottom: parent.top
        //anchors.bottomMargin: -5
        anchors.left: parent.left
        //anchors.leftMargin: 5
    }

    Rectangle
    {
	id: input
    width: parent.width
    height: parent.height/5*3
    color: "#fbd2cf"
    border.color: "#a6170b"
        Text
        {
            id: textInput
            color: "#a6170b"
            font.bold: true
            font.pointSize: 32
            text: parent.parent.text
            smooth: true
            anchors.fill: parent
            anchors.leftMargin: 24
            anchors.topMargin: 12


        }
    }

}
