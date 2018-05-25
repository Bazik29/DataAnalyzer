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

    signal loadCharact

    signal errorsfounded

    onErrorsfounded: { err_text.text = pageFileLoad.err_text; fadein.start(); }

    FontLoader {
        name: "JohnSans Lite Pro"
        source: "fonts/John_Sans_Lite_Pro.otf"
    }

    FontLoader {
        name: "JohnSans White Pro"
        source: "fonts/John_Sans_White_Pro.otf"
    }

    FontLoader {
        name: "Roboto Regular"
        source: "fonts/Roboto-Regular.ttf"
    }

    FontLoader {
        id: robotoLight
        source: "fonts/Roboto-Light.ttf"
    }

    function showMessage(msg) {
        put_error(msg)
    }

    function put_error(error){
        err_text.text = error;
        fadein.start();
    }

    function lock() {
        chars.enabled = false
        regress.enabled = false
        //pirson.enabled = false
        report.enabled = false
    }

    function unlock() {
        chars.enabled = true
        regress.enabled = true
        pirson.enabled = true
        report.enabled = true
    }


    MenuGroup {
        id: menuGroup
        selected: file
        onChangeMenu: {
            if (item == file) {
                pageFileLoad.visible = true
                pageCharact.visible = false
                padeRegress.visible = false
                pageReport.visible = false
            }
            if (item == chars) {
                loadCharact()
                pageFileLoad.visible = false
                pageCharact.visible = true
                padeRegress.visible = false
                pageReport.visible = false
            }
            if (item == report) {
                pageFileLoad.visible = false
                pageCharact.visible = false
                padeRegress.visible = false
                pageReport.visible = true
            }
            if (item == regress) {
                pageFileLoad.visible = false
                pageCharact.visible = false
                pageReport.visible = false
                padeRegress.visible = true
            }
        }
        Component.onCompleted: {
            pageFileLoad.visible = true
            chars.enabled = false
            regress.enabled = false
            pirson.enabled = false
            report.enabled = false
        }
    }

    Rectangle {
        id: content

        anchors.left: sidebar.right
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 5
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

            PageFileLoad {
                id: pageFileLoad
                anchors.fill: parent
                visible: false
            }
            PageCharact {
                id: pageCharact
                anchors.fill: parent
                visible: false
            }

            PageRegress {
                id: padeRegress
                anchors.fill: parent
                visible: false
            }

            PageReport{
                id: pageReport
                anchors.fill: parent
                visible: false
            }
        }
    }

    Rectangle {
        id: sidebar
        width: 372

        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        //color: "black"

        layer.enabled: true

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
            font.family: "Roboto Regular"

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
            visible: false
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
            anchors.leftMargin: 22
            clip: true

            contentHeight: 60*5 //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            contentWidth: menuGroup_col.width

            ScrollBar.vertical: ScrollBar { }

            boundsBehavior: Flickable.StopAtBounds

            Column {
                id: menuGroup_col
                anchors.fill: parent
                width: 328
                spacing: 10
                MenuGroupButton {
                    id: file
                    caption: "Файл"
                    icon: "elements/file_icon.png"
                    icon_inverted: "elements/b_icon_inverted.png"
                    anchors { left: parent.left; right: parent.right }
                    radioGroup: menuGroup
                }

                MenuGroupButton {
                    id: chars
                    caption: "Числовые характеристики"
                    icon: "elements/chars_icon.png"
                    icon_inverted: "elements/chars_icon_inverted.png"
                    anchors { left: parent.left; right: parent.right }
                    radioGroup: menuGroup
                    enabled: false
                }

                MenuGroupButton {
                    id: pirson
                    caption: "Критерии"
                    icon: "elements/pirson_icon.png"
                    icon_inverted: "elements/pirson_icon_inverted.png"
                    anchors { left: parent.left; right: parent.right }
                    radioGroup: menuGroup
                    enabled: false
                }

                MenuGroupButton {
                    id:regress
                    caption: "Регрессия"
                    icon: "elements/Regression_icon.png"
                    icon_inverted: "elements/Regression_icon_inverted.png"
                    anchors { left: parent.left; right: parent.right }
                    radioGroup: menuGroup
                    enabled: false
                }

                MenuGroupButton {
                    id: disp
                    caption: "Дисперсионный анализ"
                    anchors { left: parent.left; right: parent.right }
                    radioGroup: menuGroup
                    enabled: false
                }
            }
        }

        Rectangle {
            id: bot_line
            visible: false
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

        MenuGroupButton {
            id: report
            x: 20
            y: 640
            caption: "Отчет"
            enabled: false
            radioGroup: menuGroup
        }

    }

    Item{
        id: err_w
        x: 1280
        y: 560
        width: 400
        height: 150


        Rectangle{
        anchors.fill: parent
        color: "#e9403d"
        border.width: 3
        border.color: '#ffa4a3'
        }

        Text{
            x: 10
            y: 10
            color: "White"
            font.family: "Roboto Regular"
            font.pixelSize: 24
            text: "Ошибка"
        }

        Text{
            id: err_text
            x: 10
            y: 65
            width: 380
            color: "White"
            font.family: robotoLight.name
            font.weight: Font.Light
            font.pixelSize: 20
            wrapMode: "WordWrap"
            text: "Загрузка файла не возможна файл не существует"
        }

        CustButton{
            id: load
            x: 358
            y: 10
            width: 32
            height: 32
            normalSrc: "elements/btn.png"
            hoverSrc: "elements/btn_h.png"
            clickedSrc: "elements/btn.png"
            onClicked: { fadeout.start(); }
        }

        Timer{
            id: err_time
            interval: 5000
            running: false
            onTriggered:{ err_time.stop(); fadeout.start(); }
        }

        PropertyAnimation on x{
            id: fadein
            to: 880
            running: false
            onRunningChanged: {
                if (running == true) err_time.start()
            }
        }

        PropertyAnimation on x{
            id: fadeout
            to: 1280
            running: false
        }

    }

}
