import QtQuick 2.0
import QtQuick.Controls 2.0
Item {
    x: 4
    objectName: "pageReport"
    width: 900
    property string vel_x: "X"
    property string vel_y: "Y"
    property string path: "/"

    signal reportClick

    function setlabels(lx, ly){
        vel_x = lx
        vel_y = ly
    }

    function getArrayOfReport(){
        return {
            // Графики
            'graphX': ch2.checked,
            'graphY': ch3_.checked,
            'graphXY': ch1.checked,
            // Числовые хар-ки
            'charX': ch3.checked,
            'charY': ch4.checked,
            // Критерии
            'crits': sl4.checked,
            // Регрессия
            'regGraph': ch7.checked,
            'regStat': ch8.checked,
            // Дисперсия
            'dispers': sl_d.checked
            }
    }

    function getFilePath(){
        return path
    }

    Image{
        id: t_rep
        x: 25
        y: 18
        width: 851
        height: 537
        source: "elements/table_back_fill.png"
    }

    Text{
        y: t_rep.y+43
        x: t_rep.x+60
        text: "Формирование отчёта"
        font.family: "Roboto Regular"
        font.pixelSize: 20
        color: "White"
    }

    Flickable{
        id: chars_rep
        x: 25
        y: 130
        width: 830
        height: 400
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        contentHeight: 630
        ScrollBar.vertical: ScrollBar { }

        Item{
            id: hists
            x: 20
            y: 50

        Text{
            x: 76
            text: "Графики:"
            color: "black"
            font.family: robotoLight.name
            font.weight: Font.Light
            font.pixelSize: 20
        }

        Custslider{
            id: sl1
            y: -4
            checked: true
            onClicked: { if (sl1.checked) { if  (ch1.checked) ch1.clip(); if  (ch2.checked) ch2.clip(); if  (ch3_.checked) ch3_.clip(); anim1.start(); a_00.start(); a_01_.start(); a_01.start(); a_02_.start(); a_02.start(); a_03.start(); a_04.start(); a_05.start(); chars_rep.contentHeight-=150;
            } else { anim6.start(); a_25_.start(); a_26_.start(); a_24.start(); a_25.start(); a_26.start(); a_27.start(); a_28.start(); a_29.start(); chars_rep.contentHeight+=150; }

            }
        }


        Rectangle{
            y: 36
            width: 795
            height: 1
            color: "#c1c1c1"
        }

        CustCheck{
            id: ch1
            x: 50
            y: 40
            normalSrc: "elements/check_normal_checked.png"
            hoverSrc: "elements/hover_check.png"
            clickedSrc: "elements/check_normal_checked.png"
            onClicked: { ch1.clip();}

            PropertyAnimation on opacity{
                id: a_00
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_24
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        CustCheck{
            id: ch2
            x: 50
            y: 90
            normalSrc: "elements/check_normal_checked.png"
            hoverSrc: "elements/hover_check.png"
            clickedSrc: "elements/check_normal_checked.png"
            onClicked: { ch2.clip();}

            PropertyAnimation on opacity{
                id: a_01
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_25
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        CustCheck{
            id: ch3_
            x: 50
            y: 140
            normalSrc: "elements/check_normal_checked.png"
            hoverSrc: "elements/hover_check.png"
            clickedSrc: "elements/check_normal_checked.png"
            onClicked: { ch3_.clip();}

            PropertyAnimation on opacity{
                id: a_01_
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_25_
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        Text{
            x: 100
            y: 50
            text: "График выборки "
            color: "black"
            font.family: robotoLight.name
            font.weight: Font.Light
            font.pixelSize: 20

            PropertyAnimation on opacity{
                id: a_02
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_26
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        Text{
            x: 100
            y: 100
            text: "Гистограмма величины: "+vel_x
            color: "black"
            font.family: robotoLight.name
            font.weight: Font.Light
            font.pixelSize: 20

            PropertyAnimation on opacity{
                id: a_02_
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_26_
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        Rectangle{
            y: 86
            width: 795
            height: 1
            color: "#c1c1c1"

            PropertyAnimation on opacity{
                id: a_03
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_27
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        Text{
            x: 100
            y: 150
            text: "Гистограмма величины: "+vel_y
            color: "black"
            font.family: robotoLight.name
            font.weight: Font.Light
            font.pixelSize: 20

            PropertyAnimation on opacity{
                id: a_04
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_28
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        Rectangle{
            y: 136
            width: 795
            height: 1
            color: "#c1c1c1"

            PropertyAnimation on opacity{
                id: a_05
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_29
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        }

        Item{
            id: chisl
            x: 20
            y: hists.y+200


        PropertyAnimation on y{
            id: anim1
            running: false
            to: hists.y+50
            duration: 500

            //onRunningChanged: if (anim1.running == false) if (sl2.checked == false) anim2.start();
        }

        PropertyAnimation on y{
            id: anim6
            running: false
            to: hists.y+200
            duration: 500
        }

        Text{
            x: 76
            text: "Числовые характеристики"
            color: "black"
            font.family: robotoLight.name
            font.weight: Font.Light
            font.pixelSize: 20
        }

        Custslider{
            id: sl2
            y: -4
            checked: true
            onClicked: { if (sl2.checked) { if  (ch3.checked) ch3.clip(); if  (ch4.checked) ch4.clip(); anim3.start(); a_06.start(); a_07.start(); a_08.start(); a_09.start(); a_10.start(); a_11.start(); chars_rep.contentHeight-=100;
            } else { anim4.start(); a_30.start(); a_31.start(); a_32.start(); a_33.start(); a_34.start(); a_35.start(); chars_rep.contentHeight+=100; }

            }
        }

        Rectangle{
            y: 36
            width: 795
            height: 1
            color: "#c1c1c1"
        }

        CustCheck{
            id: ch3
            x: 50
            y: 40
            normalSrc: "elements/check_normal_checked.png"
            hoverSrc: "elements/hover_check.png"
            clickedSrc: "elements/check_normal_checked.png"
            onClicked: { ch3.clip();}

            PropertyAnimation on opacity{
                id: a_06
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_30
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        CustCheck{
            id: ch4
            x: 50
            y: 90
            normalSrc: "elements/check_normal_checked.png"
            hoverSrc: "elements/hover_check.png"
            clickedSrc: "elements/check_normal_checked.png"
            onClicked: { ch4.clip();}

            PropertyAnimation on opacity{
                id: a_07
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_31
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        Text{
            x: 100
            y: 50
            text: "Величина: "+vel_x
            color: "black"
            font.family: robotoLight.name
            font.weight: Font.Light
            font.pixelSize: 20

            PropertyAnimation on opacity{
                id: a_08
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_32
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        Rectangle{
            y: 86
            width: 795
            height: 1
            color: "#c1c1c1"

            PropertyAnimation on opacity{
                id: a_09
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_33
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        Text{
            x: 100
            y: 100
            text: "Величина: "+vel_y
            color: "black"
            font.family: robotoLight.name
            font.weight: Font.Light
            font.pixelSize: 20

            PropertyAnimation on opacity{
                id: a_10
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_34
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        Rectangle{
            y: 136
            width: 795
            height: 1
            color: "#c1c1c1"

            PropertyAnimation on opacity{
                id: a_11
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_35
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }
        }

        Item{
            id: criteries
            x: 20
            y: { if (anim3.running == true) chisl.y+150;
                else if (anim4.running == true) chisl.y+50;
               else { sl2.checked ? chisl.y+150 : chisl.y+50 } }

            PropertyAnimation on y{
                id: anim3
                running: false
                to: chisl.y+50
                duration: 500
            }

            PropertyAnimation on y{
                id: anim4
                running: false
                to: chisl.y+150
                duration: 500
            }

        Text{
            x: 76
            text: "Критерии"
            color: "black"
            font.family: robotoLight.name
            font.weight: Font.Light
            font.pixelSize: 20
        }


        Custslider{
            id: sl4
            y: -4
            checked: true
            onClicked: { if (sl4.checked) { anim5.start();
            } else { anim8.start(); }

            }
        }
        }

        Item{
            id: regr
            x: 20
            y: criteries.y+50 //{ if (anim5.running == true) criteries.y+50;
              //  else if (anim8.running == true) criteries.y+50;
              // else { sl4.checked ? criteries.y+150 : criteries.y+50 } }

            PropertyAnimation on y{
                id: anim5
                running: false
                to: criteries.y+50
                duration: 500
            }

            PropertyAnimation on y{
                id: anim8
                running: false
                to: criteries.y+50
                duration: 500
            }

        Text{
            x: 76
            text: "Регрессионный анализ"
            color: "black"
            font.family: robotoLight.name
            font.weight: Font.Light
            font.pixelSize: 20
        }

        Custslider{
            id: sl3
            y: -4
            checked: true
            onClicked: { if (sl3.checked) { if  (ch7.checked) ch7.clip(); if  (ch8.checked) ch8.clip(); anim10.start(); a_18.start(); a_19.start(); a_20.start(); a_21.start(); a_22.start(); a_23.start(); chars_rep.contentHeight-=100;
            } else { anim9.start(); a_42.start(); a_43.start(); a_44.start(); a_45.start(); a_46.start(); a_47.start(); chars_rep.contentHeight+=100; }

            }
        }

        Rectangle{
            y: 36
            width: 795
            height: 1
            color: "#c1c1c1"
        }

        CustCheck{
            id: ch7
            x: 50
            y: 40
            normalSrc: "elements/check_normal_checked.png"
            hoverSrc: "elements/hover_check.png"
            clickedSrc: "elements/check_normal_checked.png"
            onClicked: { ch7.clip();}

            PropertyAnimation on opacity{
                id: a_18
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_42
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        CustCheck{
            id: ch8
            x: 50
            y: 90
            normalSrc: "elements/check_normal_checked.png"
            hoverSrc: "elements/hover_check.png"
            clickedSrc: "elements/check_normal_checked.png"
            onClicked: { ch8.clip();}

            PropertyAnimation on opacity{
                id: a_19
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_43
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        Text{
            x: 100
            y: 50
            text: "График регрессии"
            color: "black"
            font.family: robotoLight.name
            font.weight: Font.Light
            font.pixelSize: 20

            PropertyAnimation on opacity{
                id: a_20
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_44
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        Rectangle{
            y: 86
            width: 795
            height: 1
            color: "#c1c1c1"

            PropertyAnimation on opacity{
                id: a_21
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_45
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }

        Text{
            x: 100
            y: 100
            text: "Параметры"
            color: "black"
            font.family: robotoLight.name
            font.weight: Font.Light
            font.pixelSize: 20

            PropertyAnimation on opacity{
                id: a_22
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_46
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }


        Rectangle{
            y: 136
            width: 795
            height: 1
            color: "#c1c1c1"

            PropertyAnimation on opacity{
                id: a_23
                running: false
                from: 1
                to: 0
                duration: 500
            }

            PropertyAnimation on opacity{
                id: a_47
                running: false
                from: 0
                to: 1
                duration: 500
            }
        }
        }

    Item{
        id: disp
        x: 20
        y: { if (anim10.running == true) regr.y+150;
            else if (anim9.running == true) regr.y+50;
           else { sl3.checked ? regr.y+150 : regr.y+50 } }

        PropertyAnimation on y{
            id: anim10
            running: false
            to: regr.y+50
            duration: 500
        }

        PropertyAnimation on y{
            id: anim9
            running: false
            to: regr.y+150
            duration: 500
        }

        Text{
            x: 76
            text: "Дисперсионный анализ"
            color: "black"
            font.family: robotoLight.name
            font.weight: Font.Light
            font.pixelSize: 20
        }

        Custslider{
            id: sl_d
            y: -4
            checked: true
        }

    }


    }

    CustButton{
        id: getreport
        x: 295
        y: 598
        width: 328
        height: 68
        normalSrc: "elements/btn_1.png"
        hoverSrc: "elements/btn_2.png"
        clickedSrc: "elements/btn_1.png"
        caption: "Сформировать"
        textcolor: "white"
        posx: 100
        posy: 23
        onClicked: reportClick()
    }

}