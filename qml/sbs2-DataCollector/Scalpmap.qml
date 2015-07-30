import QtQuick 2.0

Rectangle {
    id: scalpmap
    property int scalling: 1
    width: 800 / scalling
    height: 480 / scalling
    color: "#f9bcb7"

    function cqValue(name,value)
    {
    //console.log(name + " "+value)
    for (var i=0; i<children.length; ++i)
    {
        if (children[i].name == name)
        children[i].value = value
        //console.log(children[i].name)
    }
    }

    Image {
    id: scalpimage
    source: "qrc:/scalpmap.png"
    anchors.fill: parent
    }

    // Emotive
    /*Electrode{name: "P7"; x: 291/scalling - 20; y: 316/scalling}
    Electrode{name: "FC6"; x: 540/scalling - 20; y: 202/scalling}
    Electrode{name: "T7"; x: 240/scalling - 20; y: 246/scalling}
    Electrode{name: "P8"; x: 534/scalling - 20; y: 316/scalling}
    Electrode{name: "O2"; x: 450/scalling - 20; y: 343/scalling}
    Electrode{name: "O1"; x: 373/scalling - 20; y: 343/scalling}
    Electrode{name: "FC5"; x: 291/scalling - 20; y: 202/scalling}
    Electrode{name: "F3"; x: 348/scalling - 20; y: 171/scalling}
    Electrode{name: "F4"; x: 484/scalling - 20; y: 171/scalling}
    Electrode{name: "T8"; x: 590/scalling - 20; y: 246/scalling}
    Electrode{name: "F7"; x: 269/scalling - 20; y: 154/scalling}
    Electrode{name: "F8"; x: 562/scalling - 20; y: 154/scalling}
    Electrode{name: "AF4"; x: 464/scalling - 20; y: 137/scalling}
    Electrode{name: "AF3"; x: 366/scalling - 20; y: 137/scalling}*/

    // Emocap
    Electrode{name: "TP10"; x: 580/scalling - 20; y: 275/scalling}
    Electrode{name: "TP9"; x: 250/scalling - 20; y: 275/scalling}
    Electrode{name: "FZ"; x: 415/scalling - 20; y: 177/scalling}
    Electrode{name: "P3"; x: 340/scalling - 20; y: 316/scalling}
    Electrode{name: "P4"; x: 483/scalling - 20; y: 316/scalling}
    Electrode{name: "CZ"; x: 415/scalling - 20; y: 246/scalling}
    Electrode{name: "C4"; x: 495/scalling - 20; y: 246/scalling}
    Electrode{name: "C3"; x: 335/scalling - 20; y: 246/scalling}
    Electrode{name: "PZ"; x: 415/scalling - 20; y: 306/scalling}
    Electrode{name: "FPZ"; x: 415/scalling - 20; y: 100/scalling}
    Electrode{name: "O1"; x: 373/scalling - 20; y: 343/scalling}
    Electrode{name: "O2"; x: 450/scalling - 20; y: 343/scalling}
    Electrode{name: "F3"; x: 348/scalling - 20; y: 171/scalling}
    Electrode{name: "F4"; x: 484/scalling - 20; y: 171/scalling}

}
