import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3

Window {
    id: page
    height: 800
    width: 1280
    visible: true

    property bool horizontal: width > height
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
        helpButtonVisible: !help.visible
        width: parent.width
        delegate: stack.item.topBarDelegate
        height: 120
        id: topbar
        onQuitTriggered: {
            help.visible ? helpStack.closeHelp() : Qt.quit()
        }

        onHelpTriggered: {
            helpStack.help()
        }
    }
    Item {
        anchors.margins: 20
        anchors.top: topbar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

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
        StackLayout {
            id: helpStack
            function help() {
                currentIndex = 1
            }
            function closeHelp() {
                currentIndex = 0
            }

            anchors.left: horizontal ? stack.right : parent.left
            anchors.right: parent.right
            anchors.top: horizontal ? parent.top : stack.bottom
            anchors.bottom: parent.bottom
            Item {
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
                Clock {
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                }
            }
            ListView {
                id: help
                model: logger.lines
                clip: true
                header: Rectangle {
                    z: 2
                    width: ListView.view.width
                    height: headerText.font.pixelSize * 2
                    color: "#ee2211"
                    Text {
                        id: headerText
                        text: "Logs"
                        anchors.centerIn: parent
                    }
                }

                delegate: Rectangle {
                    color: "#fbd2cf"
                    border.color: "#a6170b"
                    width: ListView.view.width
                    height: logLine.height
                    Text {
                        id: logLine
                        text: modelData
                        width: parent.width
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }
            }
        }
    }
}
