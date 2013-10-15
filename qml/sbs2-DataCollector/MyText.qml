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

    Rectangle
    {

	id: input
	width: parent.fakeWidth
	height: parent.fakeHeight
	color: "lightGray"
	border.color: "black"



	Text
	{
	    id: textInput
	    color: "black"
	    font.bold: true
	    font.pointSize: 32
	    text: parent.parent.text

	    smooth: true
	    anchors.fill: parent
	    anchors.leftMargin: 10
	    anchors.topMargin: 30


	}
    }
    Rectangle
    {
	width: 240
	height: 80
	color: "gray"
	border.color: "black"
	Text
	{
	    font.pointSize: 28
	    text: {return String(parent.parent.desc); }
	    anchors.centerIn: parent
	}
	anchors.bottom: parent.top
	anchors.bottomMargin: -5
	anchors.left: parent.left
	anchors.leftMargin: 5
    }
}
