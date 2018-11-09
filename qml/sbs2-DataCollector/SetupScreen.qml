import QtQuick 2.0

Item {
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

    Clock {
        x: 20
        y: page.height - 90
    }

    MyTextInput {
        id: userTextInput
        desc: "Subject's Name"
        activeFocusOnTab: true
        focus: true
        x: 24
        y: 190
    }
    MyTextInput {
        id: descriptionTextInput
        desc: "Session's Desc"
        activeFocusOnTab: true
        x: 24
        y: 420
    }

    Button {
        id: start
        desc: "start"
        x: 0
        y: 620
        width: 752
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

    Text {
        width: 340
        height: 200
        y: 200
        anchors.right: parent.right
        anchors.rightMargin: 36
        color: "#a6170b"
        text: "Tap inside each input box on the left to insert the information about the experiment\n\nClose the keyboard to set the value in the input box"
        wrapMode: "WordWrap"
    }
}
