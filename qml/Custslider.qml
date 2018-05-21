import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: slider
    width: 84
    height: 42
    property bool checked: false
    signal clicked

    Rectangle {
        id: rect
        width: 64
        height: 32
        smooth: true
        visible: false
        color: checked ? "#009788" : "#b1b2b5"
    }

    Rectangle {
        id: ball
        x: checked ? 35 : 5 //45
        y: 4
        width: 25
        height: 25
        smooth: true
        visible: false
        color: checked ? "#009788" : "#b1b2b5"
    }

    Image {
        id: mask
        source: "elements/slider_stroke.png"
        sourceSize: Qt.size(parent.width, parent.height)
        smooth: true
        visible: false
    }

    Image {
        id: mask2
        source: "elements/slider_ball.png"
        sourceSize: Qt.size(parent.width, parent.height)
        smooth: true
        visible: false
    }

    OpacityMask {
        anchors.fill: rect
        source: rect
        maskSource: mask
    }

    OpacityMask {
        anchors.fill: ball
        source: ball
        maskSource: mask2
    }

    ParallelAnimation{
        id: to_on
        NumberAnimation{
            target: ball
            property: "x"
            from: 5;
            to: 35
        }

        ColorAnimation {
            from: "#b1b2b5"
            to: "#009788"
            duration: 500
        }
    }

    ParallelAnimation{
        id: to_off
        NumberAnimation{
            target: ball
            property: "x"
            from: 35;
            to: 5
        }

        ColorAnimation {
            from: "#009788"
            to: "#b1b2b5"
            duration: 500
        }
    }

    MouseArea {
        hoverEnabled: true
        anchors.fill: slider
        onClicked: { slider.clicked(); if (checked) { checked = false; to_off.start()} else { checked = true; to_on.start()} }
    }

}
