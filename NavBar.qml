import QtQuick 2.6
import QtQuick.Window 2.2

Item{
    id:root
    property int theScore:0
    property  alias heart1: heart1
    Rectangle{
    id: navbar
    color: "#27313c"
    anchors.fill: parent
    Row{
        spacing: 20
        width: 300
        height: parent.height
        Text{
            id: score
            text: qsTr("Score: ")
            x: 10
            color: "white"
            font.pointSize: 18
        }
        Text{
            id: myScore
            text: root.theScore
            x:100
            color: "white"
            font.pointSize: 18
        }
     }
        Image {
            id: heart1
            source: "qrc:/image/heart.png"
            width:35
            height: 35
            anchors.centerIn: parent.Center
            x: navbar.width -40
        }
        Image {
            id: heart2
            source: "qrc:/image/heart.png"
            width:35
            height: 35
            anchors.centerIn: parent.Center
            x: navbar.width -85
        }
        Image {
            id: heart3
            source: "qrc:/image/heart.png"
            width:35
            height: 35
            anchors.centerIn: parent.Center
            x: navbar.width -135
        }


    }
}
