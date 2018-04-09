import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    id: button
    implicitWidth: backgroundImage.width*window.width/1280
    implicitHeight: backgroundImage.height*window.height/720
    width: backgroundImage.width*window.width/1280
    height: backgroundImage.height*window.height/720


    signal clicked
    property string normalSrc: ""
    property string hoverSrc: ""
    property string clickedSrc: ""
    property string b_icon: ""
    property string caption: ""
    property bool dis: true


    function clip(){
        backgroundImage.source = clickedSrc
        cap.color = "#ffffff"
        dis = false
    }

    function unclip(){
        dis= true
        backgroundImage.source = normalSrc
        cap.color = "#525f70"
    }

    Image {
        id: backgroundImage
        anchors.fill: button
        source: (button.enabled ? normalSrc : clickedSrc)
    }

    Image {
        x: 31
        y: 23
        source: b_icon
    }

    MouseArea {
        hoverEnabled: true
        anchors.fill: button
        onClicked: { if (dis) button.clicked() }
        onEntered: { if (dis) backgroundImage.source = hoverSrc; }
        onExited: { if (dis) { backgroundImage.source = normalSrc; cap.color = "#525f70" } }
        onPressed: { if (dis) { backgroundImage.source = clickedSrc; cap.color = "#ffffff"} }
        onReleased: { if (dis) { backgroundImage.source = (button.enabled ? hoverSrc : clickedSrc); cap.color = "#525f70" } }
    }

    Text{
        id: cap
        x: 78
        y: 24
        font.pixelSize: 22
        font.letterSpacing: -1
        text: caption
        font.family: "JohnSans Lite Pro"
        color: "#525f70"
    }
}
