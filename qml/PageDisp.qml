import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Item {
    width: 900
    objectName: "pageCrits"

    function insertvalues(fstv, pvlv){
        fst.text = fstv
        pvl.text = pvlv
    }

        Item{
            id: crits_table
            x: 25
            y: 18

            Image{
                width: 851
                height: 537
                source: "elements/table_back_fill.png"
            }

            Text{
                y: 43
                x: 60
                text: "Однофакторный дисперсионный анализ"
                font.family: "Roboto Regular"
                font.pixelSize: 20
                color: "White"
            }

            Item{
                x: 26
                y: 20

            Text{
                x: 0
                y: 120
                text: "Название выборки"
                color: "#009788"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: t_kr
                x: 416
                y: 120
                text: "F-статистика"
                color: "#009788"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                x: 676
                y: 120
                text: "p - value"
                color: "#009788"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }
            }

            Item{
                y: 150

                Rectangle{
                    x: 26
                    y: 26
                    width: 795
                    height: 1
                    color: "#c1c1c1"
                }

            Text{
                x: 26
                y: 40
                text: "Выборка 1"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: fst
                x: 440
                y: 40
                text: "default"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Text{
                id: pvl
                x: 700
                y: 40
                text: "default"
                color: "black"
                font.family: robotoLight.name
                font.weight: Font.Light
                font.pixelSize: 20
            }

            Rectangle{
                x: 26
                y: 76
                width: 795
                height: 1
                color: "#c1c1c1"
            }

            }

    }
}
