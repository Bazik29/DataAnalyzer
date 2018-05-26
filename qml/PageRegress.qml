import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Item {
    width: 900
    objectName: "pageRegress"

    function insertvalues(urav, mnR, R2, stdR, coef, count){
        t_urav.text = urav
        t_mnR.text = mnR
        t_rsq.text = R2
        t_stdEr.text = stdR
        t_coef.text = coef
        t_sees.text = count
    }

    Flickable{
        id: flick
        x: 4
        y: 0
        width: parent.width
        height: 716
        boundsBehavior: Flickable.StopAtBounds
        contentHeight: 1214
        ScrollBar.vertical: ScrollBar { }

        Image{
            x: 45
            y: 65
            width: 831
            height: 442
            id: back_graph
            source: "elements/graph_back.png"
        }

        Image {
            id: graph
            x: 25
            y: 45
            width: 831
            height: 442
            source: "elements/plot.png"
            property bool rounded: true
            property bool adapt: true

            layer.enabled: rounded
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: graph.width
                    height: graph.height
                    Rectangle {
                       anchors.centerIn: parent
                       width: graph.adapt ? graph.width : Math.min(graph.width, graph.height)
                       height: graph.adapt ? graph.height : width
                       radius: 12 //Math.min(width, height)
                    }
                }
            }
        }

        Item{
            id: chars_page
            x: 25
            y: 547

            Image{
                width: 851
                height: 537
                source: "elements/table_back_fill.png"
            }

            Text{
                y: 43
                x: 60
                text: "Регрессионная статистика"
                font.family: "Roboto Regular"
                font.pixelSize: 20
                color: "White"
            }

            Text{
                x: 26
                y: 140
                text: "Уравнение регрессии"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_urav
                x: 500
                y: 140
                text: "default"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Rectangle{
                x: 26
                y: 176
                width: 795
                height: 1
                color: "#c1c1c1"
            }

            Text{
                x: 26
                y: 190
                text: "Множественный R"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_mnR
                x: 500
                y: 190
                text: "default"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Rectangle{
                x: 26
                y: 226
                width: 795
                height: 1
                color: "#c1c1c1"
            }

            Text{
                x: 26
                y: 240
                text: "R-квадрат"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_rsq
                x: 500
                y: 240
                text: "default"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Rectangle{
                x: 26
                y: 276
                width: 795
                height: 1
                color: "#c1c1c1"
            }

            Text{
                x: 26
                y: 290
                text: "Коэффициент регрессии"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_coef
                x: 500
                y: 290
                text: "default"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Rectangle{
                x: 26
                y: 326
                width: 795
                height: 1
                color: "#c1c1c1"
            }

            Text{
                x: 26
                y: 340
                text: "Стандартная ошибка"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_stdEr
                x: 500
                y: 340
                text: "default"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Rectangle{
                x: 26
                y: 376
                width: 795
                height: 1
                color: "#c1c1c1"
            }

            Text{
                x: 26
                y: 390
                text: "Число наблюдений"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_sees
                x: 500
                y: 390
                text: "default"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }
        }
    }
}
