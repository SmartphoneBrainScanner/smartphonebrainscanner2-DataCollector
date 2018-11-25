import QtQuick 2.0

Column {
    spacing: 40
    id: setupScreen

    readonly property alias username: userTextInput.text
    readonly property alias description: descriptionTextInput.text

    readonly property bool startReady: username !== "" && description !== ""

    signal startClicked
    property var topBarDelegate: Component {
        Item {
            Text {
                color: "#eee"
                anchors.verticalCenter: parent.verticalCenter
                text: page.title
                font.family: "Helvetica"
                font.bold: true
            }
        }
    }


    MyTextInput {
        id: userTextInput
        desc: "Subject's Name"
        activeFocusOnTab: true
        focus: true
        anchors.left: start.left
    }
    MyTextInput {
        id: descriptionTextInput
        desc: "Session's Desc"
        activeFocusOnTab: true
        anchors.left: start.left
    }

    Button {
        id: start
        desc: "start"
        width: parent.width * .9
        height: 90
        activeFocusOnTab: true
        radius: 10
        anchors.horizontalCenter: parent.horizontalCenter
        isReady: setupScreen.startReady
        onClicked: {
            console.log("THIS: " + userTextInput.text + " " + userTextInput.desc)
            console.log("THIS2:" + descriptionTextInput.text + " " + descriptionTextInput.desc)
            page.startRecording(userTextInput.text, descriptionTextInput.text)
            startClicked()
            focus = false
        }
    }
}
