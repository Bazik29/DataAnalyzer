import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Item {
    width: 900
    objectName: "pageCharact"

    property string vel_x: "X"
    property string vel_y: "Y"


    signal loadX
    signal loadY
    signal loadXY

    FontLoader {
        name: "Roboto Regular"
        source: "fonts/Roboto-Regular.ttf"
    }

    FontLoader {
        id: robotoLight
        source: "fonts/Roboto-Light.ttf"
    }

    function insertlabels(lx, ly){
        vel_x = lx
        vel_y = ly
    }

    function setgraphsource(source) {
        graph.source = source
    }

    function swappages(idx){
        if (idx == 0) { 
            loadXY()
            chars_page.visible = false
            flick.contentHeight = 657
        }
        if (idx == 1) { 
            loadX()
            chars_page.visible = true
            flick.contentHeight = 1214
        }
        if (idx == 2) { 
            loadY()
            chars_page.visible = true
            flick.contentHeight = 1214
        }
    }

    function insertvalues(mean, mode, median, std, dispersion, variation, skew, kurtosis){
        t_mean.text = mean
        t_mode.text = mode
        t_median.text = median
        t_std.text = std
        t_dispersion.text = dispersion
        t_variation.text = variation
        t_skew.text = skew
        t_kurtosis.text = kurtosis
    }

    Flickable{
        id: flick
        x: 0
        y: 80
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
            //source: "elements/plot.png"
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
                text: "Характеристики"
                font.family: "Roboto Regular"
                font.pixelSize: 20
                color: "White"
            }

            Text{
                x: 26
                y: 140
                text: "Среднее значение"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_mean
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

            //Средн значение, дисперсия, срквадр откл, коэф вари. коэф асси, эксцесс

            Text{
                x: 26
                y: 190
                text: "Медиана"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_median
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
                text: "Мода"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_mode
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
                text: "Дисперсия"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_dispersion
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
                text: "Среднеквадратичное отклонение"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_std
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
                text: "Коэфициэнт вариации"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_variation
                x: 500
                y: 390
                text: "default"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Rectangle{
                x: 26
                y: 426
                width: 795
                height: 1
                color: "#c1c1c1"
            }

            Text{
                x: 26
                y: 440
                text: "Коэфициэнт ассиметрии"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_skew
                x: 500
                y: 440
                text: "default"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Rectangle{
                x: 26
                y: 476
                width: 795
                height: 1
                color: "#c1c1c1"
            }


            Text{
                x: 26
                y: 490
                text: "Коэфициэнт эксцесса"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_kurtosis
                x: 500
                y: 490
                text: "default"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

        }

    }

    ComboBox{
        id: control
        x: 50
        y: 20
        width: 800
        height: 60
        font.pixelSize: 20
        model: ["Зависимость "+vel_x+" от "+vel_y, "Величина "+vel_x, "Величина "+vel_y]

        onCurrentIndexChanged: swappages(control.currentIndex)

        delegate: ItemDelegate {
            width: control.width
            height: control.height
            contentItem:
            Text {
                text: modelData
                font.family: "Roboto Regular"
                font.pixelSize: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            highlighted: control.highlightedIndex === index
        }

        background: Rectangle {
            color: control.pressed ? '#006359' : '#009788'
            radius: 5
        }

        contentItem: Text {
            leftPadding: 0
            rightPadding: control.indicator.width + control.spacing
            text: control.displayText
            font.family: "Robot Regular"
            font.pixelSize: 20
            color: "white"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        popup: Popup {
            y: control.height - 1
            width: control.width
            implicitHeight: contentItem.implicitHeight
            padding: 1

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: control.popup.visible ? control.delegateModel : null
                currentIndex: control.highlightedIndex
                ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle {
                color: "#c1c1c1"
                radius: 5
            }
        }
    }

}
