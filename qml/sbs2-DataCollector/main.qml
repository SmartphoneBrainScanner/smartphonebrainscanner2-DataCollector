import QtQuick 2.0

Rectangle {
    id: page
    width: 800
    height: 1280
    color: "black"
    state: "startupScreen"
    property string title: "sbs2-DataCollector"
    property bool setupScreenVisible: true
    property bool vizVisible: false

    signal event(string eventType)
    signal startRecording(string user, string desc)
    signal stopRecording

    function cqUpdated(channel, value) {
        setupScreen.cqValue(channel, value)
        viz.cqValue(channel, value)
    }

    function currentPacket(value) {
        viz.currentPacket(value)
    }

    states: [
        State {
            name: "startupScreen"
            PropertyChanges {
                target: page
            }
        },
        State {
            name: "show"
            PropertyChanges {
                target: page
                setupScreenVisible: false
                vizVisible: true
            }
        }
    ]

    SetupScreen {
        id: setupScreen
        visible: page.setupScreenVisible
    }
    Viz {
        id: viz
        visible: page.vizVisible
    }
}
