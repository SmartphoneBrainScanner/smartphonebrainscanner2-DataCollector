import QtQuick 2.0

Rectangle {
    id: setupScreen
    color: "#f9bcb7"
    anchors.fill: parent
    property int counter: 0
    property int direction: 1

    readonly property alias username: userTextInput.text
    readonly property alias description: descriptionTextInput.text

    readonly property bool startReady: username !== "" && description !== "";

    function cqValue(name, value) {
        scalpmap.cqValue(name, value)
        setupScreen.counter = (setupScreen.counter + direction)
        if (setupScreen.counter == 100)
            direction = -1
        if (setupScreen.counter == 0)
            direction = 1
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
        radius: 10
        anchors.horizontalCenter: parent.horizontalCenter
        isReady: setupScreen.startReady
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

    Rectangle {
        id: aliveIndicator
        width: 15 * (setupScreen.counter + 1) / 100.0
        height: start.height
        color: "black"
        anchors.bottom: start.bottom
        anchors.left: start.right
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 300
            easing.type: Easing.InOutBounce
        }
    }
    Behavior on x {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutBounce
        }
    }
}
