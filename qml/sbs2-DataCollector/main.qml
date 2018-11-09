import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    id: page
    anchors.fill: parent
    width: 800
    height: 1280

    property bool horizontal: width > height
    state: "startupScreen"
    property string title: "sbs2-DataCollector"
    color: "#f9bcb7"

    signal event(string eventType)
    signal startRecording(string user, string desc)
    signal stopRecording

    function cqUpdated(channel, value) {
        scalpmap.cqValue(channel, value)
        aliveIndicator.poke()
    }

    function currentPacket(value) {
        viz.packageCount = value
    }
    TopBar {
        width: parent.width
        delegate: stack.item.topBarDelegate
        height: 120
    }

    StackLayout {
        id: stack
        width: horizontal ? parent.width / 2 : parent.width
        height: horizontal ? parent.height : parent.height / 2
        property var item: children[stack.currentIndex]
        SetupScreen {
            id: setupScreen
            onStartClicked: stack.currentIndex = 1
        }
        Viz {
            id: viz
            username: setupScreen.username
            description: setupScreen.description
        }
    }
    Item {
        anchors.left: horizontal ? stack.right : parent.left
        anchors.right: parent.right
        anchors.top: horizontal ? parent.top : stack.bottom
        anchors.bottom: parent.bottom
        Scalpmap {
            id: scalpmap
            anchors.centerIn: parent
        }
        AliveIndicator {
            anchors.bottom: parent.bottom
            height: 120 // start.height
            width: height
            anchors.right: parent.right
            id: aliveIndicator
        }
    }
}
