import QtQuick 2.0

Rectangle {
    width: 752
    height: 90
    color: "#ee2211"
    opacity: {if (desc == "quit" || isReady) return 1; return 0.4}
    property string desc
    x: 0
    y: 0
    property bool isReady: true


    Text {
    color: "#eee"
	text: parent.desc
	font.pointSize: 36
	anchors.centerIn: parent
	font.bold: true
    }

    MouseArea
    {
	anchors.fill: parent
	onClicked:
	{
	    if (parent.desc == "quit")
		Qt.quit();
	    if (parent.desc == "start" && isReady)
	    {
		console.log("THIS: "+userTextInput.text+" "+userTextInput.desc);
		console.log("THIS2:"+descriptionTextInput.text+" "+descriptionTextInput.desc);
		page.state = "show";
		page.startRecording(userTextInput.text,descriptionTextInput.text)

	    }
	}
    }
}
