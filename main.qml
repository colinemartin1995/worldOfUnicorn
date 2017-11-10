import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    id: mainWindow
    visible: true
    Column{
        anchors.fill: parent
//        width : mainWindow.width
//        height: mainWindow.height
        NavBar{
            id:myNav
            width: mainWindow.width
            height: 90
            theScore: 0
        }
        Game{
            width: mainWindow.width
            height: 500
            //onWinned:

             onCarrotEaten:{

             myNav.theScore=myNav.theScore+100;
             console.log("je suis dans le main")
             console.log(myNav.theScore)
             }
             onEnnemyKill:{
                 myNav.heart1.destroy();
                 console.log("hey destroy me!");
             }




            //nbCarot:
        }
    }

}
