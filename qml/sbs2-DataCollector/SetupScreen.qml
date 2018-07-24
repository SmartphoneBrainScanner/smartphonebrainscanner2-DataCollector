import QtQuick 2.0

Rectangle {
    id: setupScreen
    color: "#f9bcb7"
    anchors.fill: parent

    readonly property alias username: userTextInput.text
    readonly property alias description: descriptionTextInput.text

    readonly property bool startReady: username !== "" && description !== ""

    function cqValue(name, value) {
        scalpmap.cqValue(name, value)
        aliveIndicator.poke()
    }

    Rectangle {
        color: "#ee2211"
        width: parent.width
        height: 120

        Text {
            x: 24
            anchors.verticalCenter: parent.verticalCenter
            color: "#eee"
            text: page.title
            font.family: "Helvetica"
            font.bold: true
        }

        Button {
            id: quit
            height: parent.height
            width: height
            color: "#a6170b"
            anchors.right: parent.right
            desc: "x"
            onClicked: {
                Qt.quit()
            }
        }
    }
    Scalpmap {
        id: scalpmap
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
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
            page.state = "show"
            page.startRecording(userTextInput.text, descriptionTextInput.text)
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

    Item {
        property int counter: 0
        property int direction: 1
        function poke() {
            counter = (counter + direction)
            if (counter === 100)
                direction = -1
            if (counter === 0)
                direction = 1
        }

        anchors.bottom: start.bottom
        anchors.left: start.right
        height: start.height
        anchors.right: parent.right
        id: aliveIndicator
        Rectangle {
            width: parent.width * (parent.counter + 1) / 100.0
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            color: "black"
        }
    }
}
