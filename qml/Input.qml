import QtQuick 2.7

Item{
	id: sample

	property string caption: ""
	property string text: ""

	Rectangle{
		id: underline
        x: 0
        y: 32
        width: 795
        height: 1
		color: "#009788"
		scale: 0
	}

	Text{
		id: obj
		text: caption
        color: "black"
        font.family: robotoLight.name
        font.weight: Font.Light
        font.pixelSize: 20

		ParallelAnimation{
			running: false
			id: t_anim1
			NumberAnimation{
				target: obj
				property: "y"
				from: 0
                to: -25
			}
			NumberAnimation{
				target: obj
				property: "font.pixelSize"
                from: 20
                to: 14
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
                from: -25
				to: 0
			}

			NumberAnimation{
				target: obj
				property: "font.pixelSize"
                from: 14
                to: 20
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
        color: "black"
        font.family: robotoLight.name
        font.weight: Font.Light
        font.pixelSize: 20

		
		onActiveFocusChanged:  if (obj1.activeFocus) t_anim1.start(); else if (obj1.text == "") t_anim2.start();
	
		onEditingFinished: sample.text = obj1.text
		//onTextEdited: sample.text = obj1.text
	}

}
