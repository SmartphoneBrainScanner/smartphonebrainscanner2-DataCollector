import QtQuick 2.0

Text {
    id: time
    text: " "
    property int move: 0

    Component.onCompleted: set()

    function set() {
        var currentTime = new Date()
        time.text = currentTime.toTimeString("HH:mm:ss")
        var seconds = currentTime.getSeconds()
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

    color: "grey"
    font.family: "Helvetica"
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
