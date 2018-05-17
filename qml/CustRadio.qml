import QtQuick 2.0

Item {
    id: radio
    width: 48
    height: 48

    signal clicked
    property string normalSrc: ""
    property string hoverSrc: ""
    property string clickedSrc: ""
    property bool checked: false

    function clip(){
        if (!checked){
        large.start()
        checked = true;
        }
    }

    function unclip(){
        if (checked){
        small.start();
        checked = false;
        }
    }

    function init(){
        if (checked) large.start();
    }


    Image {
        id: backgroundImage
        anchors.fill: radio
        source: normalSrc
    }

    Image {
        id: circle
        width: 26
        height: 26
        x: 11
        y: 11
        source: "elements/radio_circle.png"
        scale: 0

    }

    PropertyAnimation{
        target: circle
        property: "scale"
        id: large
        to: 1.0
    }

    PropertyAnimation{
        target: circle
        property: "scale"
        id: small
        to: 0.0
    }

    MouseArea {
        hoverEnabled: true
        anchors.fill: radio
        onClicked: { radio.clicked(); }
        onEntered: { if (!checked) backgroundImage.source = hoverSrc; }
        onExited:  { if (!checked) backgroundImage.source = normalSrc; }
        onPressed: { if (!checked) { backgroundImage.source = normalSrc;} }
        onReleased: { if (!checked) { backgroundImage.source = normalSrc;} }
    }

}
