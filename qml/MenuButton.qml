import QtQuick 2.7

Rectangle {
	id: button
	property string icon: "elements/test_icon.png"
	property string caption: "Untitle"

	color:  mouseArea.containsMouse ? '#ebedef' : '#009788'

	MouseArea {
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
		//onClicked:
	}

	Image {
		source: icon
		anchors.verticalCenter: parent.verticalCenter
		anchors.left: parent.left
		anchors.leftMargin: 20
		Text {
			anchors.left: parent.right
			anchors.verticalCenter: parent.verticalCenter
			anchors.leftMargin: 5
			font.pixelSize: 22
			font.letterSpacing: -1
			text: caption
			font.family: "JohnSans Lite Pro"
			color: '#525f70'
		}
	}
}
