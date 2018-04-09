import QtQuick 2.7

Item{
	id: sample

	property string caption: ""
	property string text: ""

	Rectangle{
		id: underline
		x: -5
		y: 42
		width: 835
		height: 3
		color: "#009788"
		scale: 0
	}

	Text{
		id: obj
		text: caption
		font.family: "JohnSans White Pro"
		font.pixelSize: 32
		color: "#525f70"

		ParallelAnimation{
			running: false
			id: t_anim1
			NumberAnimation{
				target: obj
				property: "y"
				from: 0
				to: -20
			}
			NumberAnimation{
				target: obj
				property: "font.pixelSize"
				from: 32
				to: 20
			}
			NumberAnimation{
				target: underline
				property: "scale"
				from: 0
				to: 1
			}

		}
		ParallelAnimation{
			running: false
			id: t_anim2
			NumberAnimation{
				target: obj
				property: "y"
				from: -20
				to: 0
			}

			NumberAnimation{
				target: obj
				property: "font.pixelSize"
				from: 20
				to: 32
			}
			NumberAnimation{
				target: underline
				property: "scale"
				from: 1
				to: 0
			}

		}
	}

	TextInput{
		id: obj1
		width: 835
		maximumLength: 52
		height: 65
		font.family: "JohnSans White Pro"
		font.pixelSize: 30
		color: "#525f70"

		
		onActiveFocusChanged:  if (obj1.activeFocus) t_anim1.start(); else if (obj1.text == "") t_anim2.start();
	
		onEditingFinished: sample.text = obj1.text
		//onTextEdited: sample.text = obj1.text
	}

}
