import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    property color unfocused: "gainsboro"
    property color focusedColor: "silver"
    property color focusedTextColor: "black"
    property int tabTopMargin: 5
    property color paneBackgroundColor: "white"
    property int paneMargins: 10

    TabBar {
        id: tabBar
        height: 40
        spacing: -0.5
        width: parent.width
        Material.accent: "steelblue"
        Material.foreground: "steelblue"
        anchors {
            topMargin: tabTopMargin
            leftMargin: tabTopMargin * 4
            rightMargin: tabTopMargin * 4
            left: parent.left
            right: parent.right
            top: parent.top
        }

        TabButton {
            text: "Add"
            background: Rectangle {
                color: tabBar.currentIndex == 0 ? focusedColor : unfocused
            }
            Material.accent: focusedTextColor
        }
        TabButton {
            text: "Update"
            background: Rectangle {
                color: tabBar.currentIndex == 1 ? focusedColor : unfocused
            }
            Material.accent: focusedTextColor
        }
        TabButton {
            text: "Query"
            background: Rectangle {
                color: tabBar.currentIndex == 2 ? focusedColor : unfocused
            }
            Material.accent: focusedTextColor
        }
    }
    Pane {
        id: pane
        Material.background: paneBackgroundColor
        Material.elevation: 8
        anchors {
            top: tabBar.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
            margins: paneMargins
            topMargin: 0
        }
        SwipeView {
            clip: true
            currentIndex: tabBar.currentIndex
            anchors {
                fill: parent
            }
            interactive: false
            Item {

            }
            Item {

            }
            Item {


            }
        }

    }

}
