import QtQuick 2.6
import QtQuick.Window 2.2
import QtSensors 5.9

Rectangle {
    id: game
    visible: true
    color: "red"
    focus: true
    Keys.onReleased:{
        if (event.key === Qt.Key_Z)
            bubble.y--;
        else if (event.key === Qt.Key_S)
            bubble.y++;
        else if (event.key === Qt.Key_Q)
            bubble.x--;
        else if (event.key === Qt.Key_D)
            bubble.x++;
    }
    Grid{
        id: lab
        width: parent.width
        height: width
        columns: 15
        rows:15
        Repeater{
            model: [-1,0,2,1,1,0,1,0,1,0,1,0,1,0,1,0,0,2,0,1,0,1,0,0,0,0,0,0,0,1,0,1,2,1,1,0,1,1,1,0,1,0,1,0,1,0,1,2,1,0,0,1,0,1,0,1,1,1,1,1,0,0,2,1,1,1,1,1,1,1,1,0,0,0,1,1,1,2,1,0,0,0,0,1,0,1,1,1,0,0,1,0,2,0,0,1,0,1,1,0,0,0,1,1,0,0,2,2,2,1,1,1,1,0,0,1,1,1,0,0,1,2,1,2,2,2,2,2,0,1,1,0,1,1,1,1,0,1,0,1,0,1,2,2,1,0,0,0,0,1,0,0,1,1,1,1,1,0,2,1,1,2,1,0,0,1,1,1,0,1,0,0,0,2,2,2,2,1,0,1,1,0,1,0,0,0,1,0,1,1,0,2,0,0,0,1,0,1,0,1,0,0,0,1,0,0,2,2,0,0,0,0,1,0,1,1,0,1,1,1,1,0,1,0,3]
            delegate: Image{
                width: lab.width/15
                height: width
                source: modelData === 1 ?  "qrc:/image/haie.jpg" : "qrc:/image/chemin.jpg"
            }
        }
    }
    signal carrotEaten
    signal ennemyKill
    onCarrotEaten: console.log("salut")
    //    Component.onCompleted:{
    //        console.log("TestIntersect :" + myCalcul.intersects( Qt.rect(0,0,100,50),Qt.rect(25,25,100,50)) ? "ok" : "ko")
    //    }
    Accelerometer {
        id: accel
        dataRate: 100
        active:true
        onReadingChanged: {
            var newX = (bubble.x + calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * .1)
            var newY = (bubble.y - calcPitch(accel.reading.x, accel.reading.y, accel.reading.z) * .3)
            if (isNaN(newX) || isNaN(newY))
                return;
            if (newX < 0)
                newX = 0
            if (newX > game.width - bubble.width)
                newX = game.width - bubble.width
            if (newY < 18)
                newY = 18
            if (newY > game.height - bubble.height)
                newY = game.height - bubble.height
            bubble.x = newX
            bubble.y = newY
        }
    }
    function calcPitch(x,y,z) {
        return -(Math.atan(y / Math.sqrt(x * x + z * z)) * 57.2957795);
    }
    function calcRoll(x,y,z) {
        return -(Math.atan(x / Math.sqrt(y * y + z * z)) * 57.2957795);
    }
    Image {
        id: bubble
        source: "qrc:/image/unicorn.png"
        smooth: true
        width: lab.width/15.5
        height: width
        property real centerX: game.width / 2
        property real centerY: game.height / 2
        property real bubbleCenter: bubble.width / 2
        x: 0
        y: 0
        onXChanged:{
            ennemy1.x=bubble.x;
        }
        onYChanged: {
             ennemy1.y=bubble.y;
        }
        Behavior on y {
            SmoothedAnimation {
                easing.type: Easing.Linear
                duration: 10
            }
        }
        Behavior on x {
            SmoothedAnimation {
                easing.type: Easing.Linear
                duration: 10
            }
        }
    }
    Image {
        id: carotte1
        source: "qrc:/image/carotte.png"
        width:lab.width/15.5
        height: width
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        property bool superposition:myCalcul.intersects( Qt.rect(x,y,width,height),Qt.rect(bubble.x,bubble.y,bubble.width, bubble.height))
        onSuperpositionChanged:{
            if(superposition==true){
                destroy();
                game.carrotEaten();
            }
        }
    }
    Image{
        id:ennemy1
        source: "qrc:/image/dragon.png"
        width:lab.width/15.5
        height: width
        x:-50
        y:-50
        property bool superposition:myCalcul.intersects( Qt.rect(x,y,width,height),Qt.rect(bubble.x,bubble.y,bubble.width, bubble.height))
        onSuperpositionChanged:{
            if(superposition==true){
                game.ennemyKill();
                console.log("toto");
            }
        }
        Behavior on x{
             NumberAnimation {
                easing.type: Easing.Linear
                duration: 2000
            }
        }
        Behavior on y{
            NumberAnimation {
                easing.type: Easing.Linear
                duration: 2000
            }
        }
    }


    //    MouseArea{
    //    anchors.fill: carotte1
    //    onClicked: carotte1.destroy();
    //    }
}
