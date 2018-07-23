import QtQuick 2.0

Rectangle {
    id: setupScreen
    color: "#f9bcb7"
    anchors.fill: parent
    property int counter: 0
    property int direction: 1

    property bool userVisible: true
    property bool descVisible: false

    property string username: ""
    property string description: ""

    property bool usernameSet: false
    property bool descriptionSet: false

    property bool startReady: false

    function cqValue(name, value) {
        scalpmap.cqValue(name, value)
        setupScreen.counter = (setupScreen.counter + direction)
        if (setupScreen.counter == 100)
            direction = -1
        if (setupScreen.counter == 0)
            direction = 1
    }

    function userInput(username_) {
        setupScreen.username = username_
        setupScreen.userVisible = false
        setupScreen.descVisible = true
        setupScreen.usernameSet = 1
    }

    function descInput(description_) {
        setupScreen.description = description_
        setupScreen.userVisible = false
        setupScreen.descVisible = false
        setupScreen.descriptionSet = 1
        setupScreen.startReady = true
    }

    function setFocunOnDescriptionInput() {
        descText.forceActiveFocus()
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

    Text {
        id: time
        text: " "
        property int move: 0

        Component.onCompleted: set()

        function set() {
            var currentTime = new Date()
            var hours = currentTime.getHours()
            var minutes = currentTime.getMinutes()
            var seconds = currentTime.getSeconds()
            var timeString = ""
            if (minutes < 10) {
                minutes = "0" + minutes
            }
            if (hours < 10) {
                hours = "0" + hours
            }
            if (seconds < 10) {
                seconds = "0" + seconds
            }

            timeString += hours + ":" + minutes + ":" + seconds

            time.text = timeString
            time.move = seconds
        }

        Timer {
            id: timeTimer
            interval: 1000
            repeat: true
            running: true
            onTriggered: {
                time.set()
            }
        }

        x: 20
        y: page.height - 90
        color: "grey"
        font.family: "Helvetica"
        font.pointSize: 27
        font.bold: true

        Rectangle {
            color: "grey"
            anchors.top: parent.bottom
            anchors.topMargin: 0

            width: parent.width
            height: 10
            Behavior on width {
                NumberAnimation {
                    easing.type: Easing.InOutBounce
                }
            }
            Rectangle {
                color: "black"
                height: parent.height
                width: 10
                x: time.move / 60.0 * parent.width - width
                opacity: time.move / 60.0

                Behavior on x {
                    NumberAnimation {
                        easing.type: Easing.InOutBounce
                    }
                }
            }
        }
    }

    MyTextInput {
        id: userTextInput
        desc: "Subject's Name"
        x: 24
        y: 250
        visible: setupScreen.userVisible
    }
    MyTextInput {
        id: descriptionTextInput
        desc: "Session's Desc"
        x: 24
        y: 480
        visible: setupScreen.descVisible
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

    MyText {
        id: userText
        desc: "Subject's Name"
        x: 24
        y: 240
        visible: !setupScreen.userVisible
        text: setupScreen.username
    }
    MyText {
        id: descText
        desc: "Session's Desc"
        x: 24
        y: 460
        visible: !setupScreen.descVisible
        text: setupScreen.description
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
