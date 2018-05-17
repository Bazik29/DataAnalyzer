import QtQuick 2.0

Item {
    id: check
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
        else {
        small.start();
        checked = false;
        }
    }



    Image {
        id: backgroundImage
        anchors.fill: check
        source: normalSrc
    }

    Rectangle {
        id: mask
        x: 11
        y: 11
        width: 25
        height: 25
        color: "#f8fafb"
    }

    Image{
        id: hoverImage
        visible: false
        anchors.fill: check
        source: hoverSrc
    }

    ParallelAnimation{
        id: large
    PropertyAnimation{
        target: mask
        property: "width"
        to: 0
    }
    PropertyAnimation{
        target: mask
        property: "x"
        to: 36
    }

    }

    ParallelAnimation{
        id: small
    PropertyAnimation{
        target: mask
        property: "width"
        to: 25
    }
    PropertyAnimation{
        target: mask
        property: "x"
        to: 11
    }

    }


    MouseArea {
        hoverEnabled: true
        anchors.fill: check
        onClicked: { check.clicked(); }
        onEntered: {  hoverImage.visible = true }
        onExited:  { hoverImage.visible = false }
        onPressed: { hoverImage.visible = true }
        onReleased: { hoverImage.visible = false }
    }
}
