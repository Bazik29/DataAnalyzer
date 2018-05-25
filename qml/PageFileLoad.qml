import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.1

Item {
    x: -425
    y: 18
    objectName: "pageFileLoad"

    property string path: ""
    property string err_text: ""


    signal openFileClick


    function getFilePath() {
        return path
    }

    function getSeparator() {
        if (rad1.checked) return '/t'
        if (rad2.checked) return ' '
        if (rad3.checked) return '   '
        if (rad4.checked) return ';'
        return ','
    }

    function getFiksWidth(){
        if (fiks.text == "") return 1
        else return toint(fiks.text)
    }

    function getDecimalSym() {
        if (symbol.text == "") return '.'
        else return symbol.text
    }

    function haveTitle() {
        if (name.text == "") return 'Выборка'
        else return name.text
    }

    function getNameX() {
        if (idx.text == "") return 'X'
        else return idx.text
    }

    function getNameY() {
        if (idy.text == "") return 'Y'
        else return idy.text
    }


    function checkOnErrors(){
        if (rad4.checked){
        var str = symbol.text
        console.log('разделитель '+str)
       // for (var i in str){
            if (!isNaN(str)){
                err_text = "Символ разделителя не может содержать числа"
                errorsfounded()
                return 1
            }
       // }
        }
        if (rad3.checked){
            str = fiks.text
            if (isNaN(str)){
                err_text = "Ширина не может быть символом"
                errorsfounded()
                return 1
            }
            if (str<1) {
                err_text = "Ширина не может быть отрицательной"
                errorsfounded()
                return 1
            }
           }
        if (sym_num.text != ""){
           str = sym_num.text
            for (i in str){
                if (!isNaN(i)){
                    err_text = "Символ разделителя не может содержать числа"
                    errorsfounded()
                    return 1
                }
            }
        }

        return 0
    }

    Rectangle{
        id: rect
        x: 19
        y: 131
        width: 815
        height: 388
        color: "#f8fafb"


        SwipeView{
            id: view
            anchors.fill: parent
            currentIndex: 0
            spacing: 10
            interactive: false


            Item{
                id: page1

                Text{
                    id: pathFile
                    x: 12 //-18
                    y: 32 //-131
                    text: "Путь к файлу"
                    color: "black"
                    font.family: robotoLight.name
                    font.weight: Font.Light
                    font.pixelSize: 20
                }

                Rectangle{
                    x: 13
                    y: 64
                    width: 795
                    height: 1
                    color: "#c1c1c1"

                }

                Rectangle{
                    x: 13
                    y: 132
                    width: 795
                    height: 1
                    color: "#c1c1c1"
                }

                Input{
                    id: name
                    x: 13
                    y: 100
                    caption: "Название выборки"
                }

                CustButton{
                    x: 10
                    y: 151
                    width: 795
                    height: 225
                    normalSrc: "elements/file_normal.png"
                    hoverSrc: "elements/file_hovered.png"
                    clickedSrc: "elements/file_hovered.png"
                    onClicked: fileDialog.open();

                    FileDialog {
                        id: fileDialog
                        folder: "."
                        title: "Выберите файл для открытия"
                        selectMultiple: false
                        nameFilters: [ "Text files (*.csv *.txt)" ]
                        onAccepted: {
                            //console.log("Accepted: " + fileDialog.fileUrl.toString().slice(7))
                            path = fileDialog.fileUrl.toString().slice(8)
                            pathFile.text = "Путь к файлу: " + path
                        }
                    }

                    DropArea {
                        id: drop
                        anchors.fill: parent
                        onEntered: {
                            //console.log("Droparea entered-- " + drag.urls[0].toString().slice(7))
                            if (drag.urls.length == 1) {
                                path = drag.urls[0].toString().slice(7)
                                pathFile.text = "Путь к файлу: " + path
                            }
                        }

                    }
                }

            }

            Item{
                id: page2

                function unclipall(){
                    rad1.unclip();
                    rad2.unclip();
                    rad3.unclip();
                    rad4.unclip();
                    rect.forceActiveFocus();
                    rad3.setarea(800);
                    rad4.setarea(800)
                }

                function get_fh(prop){
                    if (prop){
                    rad3.setarea(48);
                    fiks.select();
                    } else {
                        rad4.setarea(48);
                        symbol.select();
                    }
                }

                CustRadio{
                    id: rad1
                    x: 12
                    y: 16
                    normalSrc: "elements/gr_normal.png"
                    hoverSrc: "elements/gr_hover.png"
                    clickedSrc: "elements/gr_normal.png"
                    onClicked: { page2.unclipall(); rad1.clip();}
                    Component.onCompleted: rad1.init();
                    checked: true
                }

                CustRadio{
                    id: rad2
                    x: 12
                    y: 84
                    normalSrc: "elements/gr_normal.png"
                    hoverSrc: "elements/gr_hover.png"
                    clickedSrc: "elements/gr_normal.png"
                    onClicked: {page2.unclipall(); rad2.clip();}
                    Component.onCompleted: rad2.init();
                }

                Rectangle{
                    x: 13
                    y: 200
                    width: 795
                    height: 1
                    color: "#c1c1c1"

                }

                Input{
                    id: fiks
                    x: 68
                    y: 162
                    line_x: -54
                    line_y: 38
                    caption: "Фиксированная ширина"
                }

                CustRadio{
                    id: rad3
                    x: 12
                    y: 152
                    normalSrc: "elements/gr_normal.png"
                    hoverSrc: "elements/gr_hover.png"
                    clickedSrc: "elements/gr_normal.png"
                    onClicked: {page2.unclipall(); rad3.clip(); page2.get_fh(true);}
                    Component.onCompleted: rad3.init();
                }

                Rectangle{
                    x: 13
                    y: 268
                    width: 795
                    height: 1
                    color: "#c1c1c1"

                }

                Input{
                    id: symbol
                    x: 68
                    y: 230
                    line_x: -54
                    line_y: 38
                    caption: "Символ"
                }

                CustRadio{
                    id: rad4
                    x: 12
                    y: 220
                    normalSrc: "elements/gr_normal.png"
                    hoverSrc: "elements/gr_hover.png"
                    clickedSrc: "elements/gr_normal.png"
                    onClicked: {page2.unclipall(); rad4.clip(); page2.get_fh(false);}
                    Component.onCompleted: rad4.init();
                }

                Text{
                    x: 68 //-18
                    y: 26 //-131
                    text: "Табуляция"
                    color: "black"
                    font.family: robotoLight.name
                    font.weight: Font.Light
                    font.pixelSize: 20
                }

                Rectangle{
                    x: 13
                    y: 64
                    width: 795
                    height: 1
                    color: "#c1c1c1"

                }


                Text{
                    x: 68
                    y: 94
                    text: "Пробел"
                    color: "black"
                    font.family: robotoLight.name
                    font.weight: Font.Light
                    font.pixelSize: 20
                }

                Rectangle{
                    x: 13
                    y: 132
                    width: 795
                    height: 1
                    color: "#c1c1c1"

                }

            }

            Item{
                id: page3

                CustCheck{
                    id: ch1
                    x: 12
                    y: 16
                    normalSrc: "elements/check_normal_checked.png"
                    hoverSrc: "elements/hover_check.png"
                    clickedSrc: "elements/check_normal_checked.png"
                    checked: true
                    onClicked: { ch1.clip(); idx.disoren(); idy.disoren(); rect.forceActiveFocus()}
                }

                Text{
                    x: 68 //-18
                    y: 26 //-131
                    text: "Первая строка является загловком"
                    color: "black"
                    font.family: robotoLight.name
                    font.weight: Font.Light
                    font.pixelSize: 20
                }

                Rectangle{
                    x: 13
                    y: 64
                    width: 795
                    height: 1
                    color: "#c1c1c1"

                }

                Rectangle{
                    x: 13
                    y: 132
                    width: 795
                    height: 1
                    color: "#c1c1c1"

                }

                Input{
                    id: idx
                    x: 13
                    y: 100
                    caption: "Имя столбца X"
                    enabled: false
                }

                Rectangle{
                    x: 13
                    y: 200
                    width: 795
                    height: 1
                    color: "#c1c1c1"

                }

                Input{
                    id: idy
                    x: 13
                    y: 168
                    caption: "Имя столбца Y"
                    enabled: false
                }

                Rectangle{
                    x: 13
                    y: 268
                    width: 795
                    height: 1
                    color: "#c1c1c1"

                }

                Input{
                    id: sym_num
                    x: 12 //-18
                    y: 236 //-131
                    caption: "Разделять доли символом:"
                }

            }

        }
    }

    Image{
        x: -53
        y: -19
        width: 952
        height: 720
        source: "elements/table_back_new.png"
    }

    Image{
        x: -30
        y: -18
        source: "elements/layer_shadow.png"
    }

    Image{
        id: swipe_element
        x: 50
        y: 24
        source: "elements/table_swipe.png"

        NumberAnimation on x{
            id: to0
            to: 50
        }
        NumberAnimation on x{
            id: to1
            to: 298
        }
        NumberAnimation on x{
            id: to2
            to: 540
        }
    }


    Button{
        x: 50
        y: 24
        width: 214
        height: 62
        Text{
            x: 14
            y: 18
            text: "Основные сведения"
            color: "white"
            font.family: "Roboto Regular"
            font.pixelSize: 20
        }
        background: Rectangle { opacity: 0}
        onClicked: { view.currentIndex = 0; to0.start() }
    }

    Button{
        x: 303
        y: 24
        width: 214
        height: 62
        Text{
            x: 14
            y: 18
            text: "Опции разделителя"
            color: "white"
            font.family: "Roboto Regular"
            font.pixelSize: 20
        }
        background: Rectangle { opacity: 0}
        onClicked: { view.currentIndex = 1; to1.start() }
    }

    Button{
        x: 567
        y: 24
        width: 214
        height: 62
        Text{
            x: 14
            y: 18
            text: "Опции данных"
            color: "white"
            font.family: "Roboto Regular"
            font.pixelSize: 20
        }
        background: Rectangle { opacity: 0}
        onClicked: { view.currentIndex = 2; to2.start() }
    }

    CustButton{
        id: load
        x: 270
        y: 580
        width: 328
        height: 68
        normalSrc: "elements/btn_1.png"
        hoverSrc: "elements/btn_2.png"
        clickedSrc: "elements/btn_1.png"
        caption: "Загрузить"
        textcolor: "white"
        posx: 117
        posy: 23
        onClicked: { rect.forceActiveFocus(); var e = checkOnErrors(); if (e == 0) { unlock(); openFileClick() } }
    }

    function get_spacer(){
        if (rad1.checked) return '/t'
        if (rad2.checked) return ' '
        if (rad3.checked) return '   '
        if (rad4.checked) return ';'
    }


}
