import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3

Item {
    width: 884
    height: 1010
    objectName: "pageFileLoad"


    signal openFileClick


    CustButton {
        id: drop_open
        x: 0
        y: 0
        height: 270
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 20
        normalSrc: "elements/file_normal.png"
        hoverSrc: "elements/file_hovered.png"
        clickedSrc: "elements/file_normal.png"
        onClicked: fileDialog.open();

       FileDialog {
            id: fileDialog
            folder: "."
            title: "Выберите файл для открытия"
            selectMultiple: false
            //nameFilters: [ "Image files (*.png *.jpg)", "All files (*)" ]
            onAccepted: { 
                console.log("Accepted: " + fileDialog.fileUrl)
                pathFile.text = fileDialog.fileUrl
            }
        }

        DropArea {
            id: drop
            anchors.fill: parent

            onEntered: {
                
                console.log("Droparea entered-- " + drag.urls[0])
                if (drag.urls.length == 1)
                    pathFile.text = drag.urls[0]
                    //!!!!!!!!!!!!!!!!!!!!!!!!!!
            }

            onExited: console.log("Droparea exited")

            onDropped: console.log("Droparea dropped")
        }
    }

    Item {
        id: menuList
        x: 0
        width: 884
        height: 624
        anchors.top: drop_open.bottom
        anchors.topMargin: 10
        clip: false


        Image {
            id: imInfo
            source: "elements/table_title.png"
            Text {
                text: "Информация о файле"
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 32
                font.family: "JohnSans Lite Pro"
                color: "#ffffff"
            }
        }
        Image {
            id: imPath
            anchors.top: imInfo.bottom
            anchors.topMargin: 0
            source: "elements/table_row.png"
            Input {
                id: pathFile
                objectName: "pathFile"
                anchors.topMargin: 10
                anchors.leftMargin: 20
                anchors.fill: parent
                caption: "Путь к файлу"
            }
        }
        Image {
            id: imNumStrok
            anchors.top: imPath.bottom
            anchors.topMargin: 0
            source: "elements/table_row.png"
            Input {
                anchors.verticalCenter: parent.verticalCenter
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.leftMargin: 20
                caption: "Строк в файле"
            }
        }
        Image {
            id: imHaveTitle
            anchors.top: imNumStrok.bottom
            anchors.topMargin: 0
            source: "elements/table_row.png"
            Text {
                id: txtFirstStr
                font.family: "JohnSans Lite Pro"
                font.pixelSize: 32
                color: "#525f70"
                text: "Первая строка является заголовком"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
            }

            Custslider {
                anchors.top: txtFirstStr.top
                anchors.topMargin: 2
                anchors.left: txtFirstStr.right
                anchors.leftMargin: 50
                checked: true
            }
        }
        Image {
            id: imCol_1
            anchors.top: imHaveTitle.bottom
            anchors.topMargin: 0
            source: "elements/table_row.png"
            Input {
                anchors.verticalCenter: parent.verticalCenter
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.leftMargin: 20
                caption: "Столбец 1"
            }
        }
        Image {
            id: imCol_2
            anchors.top: imCol_1.bottom
            anchors.topMargin: 0
            source: "elements/table_row.png"
            Input {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.leftMargin: 20
                caption: "Столбец 2"
            }
        }
        Image {
            id: imSpacer
            anchors.top: imCol_2.bottom
            anchors.topMargin: 0
            source: "elements/table_row.png"
            Text {
                font.family: "JohnSans Lite Pro"
                font.pixelSize: 20
                color: "#525f70"
                text: "Разделитель"
                anchors.leftMargin: 20
                anchors.topMargin: 10
                anchors.fill: parent
            }
        }
        Image {
            id: imDot
            anchors.top: imSpacer.bottom
            anchors.topMargin: 0
            source: "elements/table_row.png"
            Text {
                font.family: "JohnSans Lite Pro"
                font.pixelSize: 20
                color: "#525f70"
                text: "Символ отделения целых"
                anchors.leftMargin: 20
                anchors.topMargin: 10
                anchors.fill: parent
            }
        }
        Image {
            id: imLast
            anchors.top: imDot.bottom
            anchors.topMargin: 0
            source: "elements/last_row.png"
            Input {
                anchors.leftMargin: 20
                anchors.topMargin: 10
                anchors.fill: parent
                caption: "Доп 4"
            }
        }
    }

    CustButton{
        id: upload
        width: 328
        height: 76
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: menuList.bottom
        anchors.topMargin: 0
        normalSrc: "elements/button_normal.png"
        hoverSrc: "elements/button_hover.png"
        clickedSrc: "elements/button_clicked.png"
        caption: "Загрузить"
        b_icon: "elements/Regression_icon.png"
        onClicked: openFileClick()
    }
}
