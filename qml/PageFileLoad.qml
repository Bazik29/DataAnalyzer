import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.1

Item {
    width: 900
    objectName: "pageFileLoad"

    property string path: ""
    property string err_text: ""


    signal openFileClick


    function getFilePath() {
        return path
    }

    function getSeparator() {
        if (rad1.checked)
            return '/t'
        if (rad2.checked)
            return ' '
        if (rad3.checked)
            return ' '.repeat(getFiksWidth())
        if (rad4.checked)
            return symbol.text
    }

    function getFiksWidth(){
        return fiks.text == "" ? 1 : parseInt(fiks.text)
    }

    function getDecimalSym() {
        return sym_num.text == "" ? '.' : sym_num.text
    }

    function haveTitle() {
        return name.text != ""
    }

    function getTitle() {
        return name.text
    }

    function haveNames() {
        return ch1.checked
    }

    function getNameX() {
        return idx.text == "" ? 'X' : idx.text
    }

    function getNameY() {
        return idy.text == "" ? 'Y' : idy.text
    }

    function checkOnErrors(){
        if (rad4.checked){
        var str = symbol.text
            if (!isNaN(str)){
                err_text = "Символ разделителя не может содержать числа"
                errorsfounded()
                return 1
            }
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
        x: 49
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
                    caption: "Введите название выборки"
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
                        nameFilters: [ "CSV и TXT (*.csv *.txt)" ]
                        onAccepted: {
                            path = fileDialog.fileUrl.toString()
                            path = path.replace(/^(file:\/{3})/,"");
                            path = decodeURIComponent(path);
                            pathFile.text = "Путь к файлу: " + path
                        }
                    }

                    DropArea {
                        id: drop
                        anchors.fill: parent
                        onEntered: {
                            if (drag.urls.length == 1) {
                                path = drag.urls[0].toString()
                                path = path.replace(/^(file:\/{3})/,"");
                                path = decodeURIComponent(path);
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
                    Component.onCompleted: fiks.setvalidator(1)
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
                    maxlength: 1
                    Component.onCompleted: symbol.setvalidator(2);
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
                    Component.onCompleted: ch1.init();
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
                    maxlength: 1
                    Component.onCompleted: sym_num.setvalidator(3)
                }

            }

        }
    }

    Image{
        x: -23
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
        x: 100
        y: 24
        source: "elements/table_swipe.png"

        NumberAnimation on x{
            id: to0
            to: 100
        }
        NumberAnimation on x{
            id: to1
            to: 348
        }
        NumberAnimation on x{
            id: to2
            to: 590
        }
    }


    Button{
        x: 100
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
        x: 353
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
        x: 617
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
        x: 295
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
        onClicked: { 
            rect.forceActiveFocus();
            unlock() // Sorry, if I forgot delete this function. I know, it doesn't be here...
            var e = checkOnErrors();
             if (e == 0) { 
                openFileClick() 
            } 
          }
    }

    function get_spacer(){
        if (rad1.checked) return '/t'
        if (rad2.checked) return ' '
        if (rad3.checked) return '   '
        if (rad4.checked) return ';'
    }
}
