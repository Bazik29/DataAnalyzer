import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: window
    visible: true
    minimumWidth: 1280
    minimumHeight: 720
    maximumWidth: 1280
    maximumHeight: 720

    title: "Data Analyser"

    FontLoader {
        name: "JohnSans Lite Pro"
        source: "fonts/John_Sans_Lite_Pro.otf"
    }

    FontLoader {
        name: "JohnSans White Pro"
        source: "fonts/John_Sans_White_Pro.otf"
    }

    MenuGroup {
        id: menuGroup
        selected: file
        onChangeMenu: {
            if (item == file) pageLoader.source = "PageFileLoad.qml"
            if (item == chars) pageLoader.source = "PageCharact.qml"
            //if (item == pirson) text1.text="Отобразить меню Критерий Пирсона!"
            //if (item == regress) text1.text="Отобразить меню Уравнение регрессии!"
        }
        Component.onCompleted: pageLoader.source = "PageFileLoad.qml"
    }

    Rectangle {
        id: sidebar
        width: menuGroup_col.width

        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 4
            samples: 4
            radius: 4
            color: "#ABABAB"
        }

        Text {
            id: logo
            color: "#3c4858"
            text: "DATA ANALYSER"
            fontSizeMode: Text.Fit
            bottomPadding: 20
            topPadding: 20
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 28
            font.family: "JohnSans Lite Pro"

            Rectangle {
                id: rectangle
                height: 3
                color: "#dfe0e2"
                border.width: 0
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
            }
        }

        Rectangle {
            id: top_line
            height: 5
            color: "#9c9c9c"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: logo.bottom
            anchors.topMargin: 0
            border.width: 0
        }

        Flickable {
            id: flick_menu
            anchors.bottomMargin: 0
            anchors.top: top_line.bottom
            anchors.right: parent.right
            anchors.bottom: bot_line.top
            anchors.left: parent.left
            anchors.topMargin: 0
            clip: true

            contentHeight: 60*5 //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            contentWidth: menuGroup_col.width

            ScrollBar.vertical: ScrollBar { }

            boundsBehavior: Flickable.StopAtBounds

            Column {
                id: menuGroup_col
                anchors.fill: parent
                width: 320
                MenuGroupButton {
                    id: file
                    caption: "Файл"
                    icon: "elements/file_icon.png"
                    anchors { left: parent.left; right: parent.right }
                    radioGroup: menuGroup
                }

                MenuGroupButton {
                    id: chars
                    caption: "Числовые характеристики"
                    icon: "elements/chars_icon.png"
                    anchors { left: parent.left; right: parent.right }
                    radioGroup: menuGroup
                }

                MenuGroupButton {
                    id: pirson
                    caption: "Критерий Пирсона"
                    icon: "elements/pirson_icon.png"
                    anchors { left: parent.left; right: parent.right }
                    radioGroup: menuGroup
                }

                MenuGroupButton {
                    id:regress
                    caption: "Уравнение регресии"
                    icon: "elements/Regression_icon.png"
                    anchors { left: parent.left; right: parent.right }
                    radioGroup: menuGroup
                }

                MenuGroupButton {
                    caption: "Какое-то название"
                    anchors { left: parent.left; right: parent.right }
                    radioGroup: menuGroup
                }
            }
        }

        Rectangle {
            id: bot_line
            x: 0
            y: 657
            height: 5
            color: "#9c9c9c"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            border.width: 0
        }

        MenuButton {
            id: menuButton
            x: 60
            y: 660
            caption: "Отчет..."
            color: '#009788'
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: bot_line.bottom
            anchors.topMargin: 0
            anchors.left: about.right
            anchors.leftMargin: 0
        }

        Text {
            id: about
            x: 0
            y: 660
            width: 60
            height: 60
            text: "?"
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: bot_line.bottom
            anchors.topMargin: 0
            font.pointSize: 23
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.FixedSize
            font.family: "JohnSans Lite Pro"
        }
    }

    Rectangle {
        id: content

        anchors.left: sidebar.right
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        color: "#eeeeee"

        Flickable {
            id: flickable
            ScrollBar.vertical: ScrollBar { }
            boundsBehavior: Flickable.StopAtBounds
            anchors.fill: parent

            contentHeight: pageLoader.height
            Loader {
                id: pageLoader
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
