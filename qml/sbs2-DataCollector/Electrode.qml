import QtQuick 2.0

Rectangle {
    width: 40
    height: width
    radius: width/3
    property int value: 0
    smooth: true
    property string name: ""
    color: {
        if (value < 81)
        return "black"
        if (value < 221)
        return "red"
        if (value < 314)
        return "orange"
        if (value < 407)
        return "yellow"
        if (value >= 407)
        return "green"
        return "blue"
    }


}
