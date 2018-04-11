import QtQuick 2.0

Rectangle {
	id: button
	property string icon: "elements/test_icon.png"
    property string icon_inverted: "elements/test_icon.png"
	property string caption: "Untitle"
	property MenuGroup radioGroup


    Image{
        anchors.fill: parent
        id: backgroundimg
        source: radioGroup.selected === button ? "elements/button_clicked.png" :
               (mouseArea.containsMouse ? "elements/button_hover.png" : "elements/button_normal.png")
    }

    height: 76
    width: 328
	MouseArea {
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
		onClicked: {
			radioGroup.changeMenu(button)
			button.radioGroup.selected = button
		}
	}

    FontLoader {
        id: robotoLight
        source: "fonts/Roboto-Light.ttf"
    }

	Image {
        source: radioGroup.selected === button ? icon_inverted : icon
		anchors.verticalCenter: parent.verticalCenter
		anchors.left: parent.left
		anchors.leftMargin: 20
		Text {
			anchors.left: parent.right
			anchors.verticalCenter: parent.verticalCenter
			anchors.leftMargin: 10
            font.pixelSize: 20
			text: caption
            font.family: "Roboto Regular"
			color: radioGroup.selected === button ? '#ffffff' : '#525f70'
		}
	}
}
