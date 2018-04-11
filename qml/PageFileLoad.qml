import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.1

Item {
    x: -425
    y: 18
    objectName: "pageFileLoad"

    signal openFileClick

    Rectangle{
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
                x: 12 //-18
                y: 28 //-131
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


                Text{
                x: 12
                y: 88
                text: "Строк в файле"
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

            }

            Item{
                id: page2

                function unclipall(){
                    rad1.unclip();
                    rad2.unclip();
                    rad3.unclip();
                    rad4.unclip();
                }

                CustRadio{
                    id: rad1
                    x: 12
                    y: 16
                    normalSrc: "elements/gr_normal.png"
                    hoverSrc: "elements/gr_hover.png"
                    clickedSrc: "elements/gr_normal.png"
                    onClicked: { page2.unclipall(); rad1.clip();}
                }

                CustRadio{
                    id: rad2
                    x: 12
                    y: 84
                    normalSrc: "elements/gr_normal.png"
                    hoverSrc: "elements/gr_hover.png"
                    clickedSrc: "elements/gr_normal.png"
                    onClicked: {page2.unclipall(); rad2.clip();}
                }

                CustRadio{
                    id: rad3
                    x: 12
                    y: 152
                    normalSrc: "elements/gr_normal.png"
                    hoverSrc: "elements/gr_hover.png"
                    clickedSrc: "elements/gr_normal.png"
                    onClicked: {page2.unclipall(); rad3.clip();}
                }

                CustRadio{
                    id: rad4
                    x: 12
                    y: 220
                    normalSrc: "elements/gr_normal.png"
                    hoverSrc: "elements/gr_hover.png"
                    clickedSrc: "elements/gr_normal.png"
                    onClicked: {page2.unclipall(); rad4.clip();}
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

                Text{
                x: 68
                y: 162
                text: "Фикс. ширина"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
                }

                Rectangle{
                    x: 13
                    y: 200
                    width: 795
                    height: 1
                    color: "#c1c1c1"

                }

                Text{
                x: 68
                y: 230
                text: "Символ"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
                }

                Rectangle{
                    x: 13
                    y: 268
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
                    onClicked: { ch1.clip();}
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
                    x: 13
                    y: 100
                    caption: "Имя столбца X"
                }

                Rectangle{
                    x: 13
                    y: 200
                    width: 795
                    height: 1
                    color: "#c1c1c1"

                }

                Input{
                    x: 13
                    y: 168
                    caption: "Имя столбца Y"
                }

                Rectangle{
                    x: 13
                    y: 268
                    width: 795
                    height: 1
                    color: "#c1c1c1"

                }

                Text{
                x: 12 //-18
                y: 236 //-131
                text: "Разделять доли символом:"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
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
    }


}
