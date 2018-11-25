import QtQuick 2.0

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
    Rectangle {
        anchors.fill: parent
        color: "white"
        opacity: counter / 100
    }
}
