import QtQuick 2.0

Rectangle {
	id: button
	property string icon: "elements/test_icon.png"
	property string caption: "Untitle"
	property MenuGroup radioGroup

	color:  radioGroup.selected === button ? '#009788' :
			(mouseArea.containsMouse ? '#ebedef' : '#ffffff')

	height: 60
	width: 320
	MouseArea {
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
		onClicked: {
			radioGroup.changeMenu(button)
			button.radioGroup.selected = button
		}
	}

	Image {
		source: icon
		anchors.verticalCenter: parent.verticalCenter
		anchors.left: parent.left
		anchors.leftMargin: 20
		Text {
			anchors.left: parent.right
			anchors.verticalCenter: parent.verticalCenter
			anchors.leftMargin: 10
			font.pixelSize: 22
			font.letterSpacing: -1
			text: caption
			font.family: "JohnSans Lite Pro"
			color: radioGroup.selected === button ? '#ffffff' : '#525f70'
		}
	}
}
