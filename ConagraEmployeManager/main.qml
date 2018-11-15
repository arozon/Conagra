import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "./MainPages" as Pages
import artools 1.0


Window {
    visible: true
    width: 640
    height: 480
    visibility: "Maximized"
    title: qsTr("Conagra Employe Manager")


    property color tabBackgroundColor: "gainsboro"

    Backend {
        id: backend
    }


    TabBar {
        clip: true
        id: tabBar
        height: 40
        spacing: -0.5
        width: parent.width
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        Material.foreground: "white"
        Material.accent: "black"

        TabButton {
            text: "Schedule"
            background: Rectangle {
                border.color: "darkgrey"
                height: tabBar.height + 1
                border.width: 0
                color: tabBar.currentIndex === 0 ? "steelblue" : "black"
            }
            Material.accent: "white"
        }
        TabButton {
            text: "Abcenses"
            background: Rectangle {
                border.color: "darkgrey"
                height: tabBar.height + 1

                border.width: 0
                color: tabBar.currentIndex === 1 ? "green" : "black"
            }
            Material.accent: "white"
        }
        TabButton {
            text: "Vacations"
            background: Rectangle {
                border.color: "darkgrey"
                border.width: 0
                height: tabBar.height + 1
                color: tabBar.currentIndex === 2 ? "yellow" : "black"
            }
            Material.accent: "black"
        }
        TabButton {
            text: "Employes"
            background: Rectangle {
                border.color: "darkgrey"
                height: tabBar.height + 1
                border.width: 0
                color: tabBar.currentIndex === 3 ? "pink" : "black"
            }
            Material.accent: "black"
        }
        TabButton {
            text: "Productions"
            background: Rectangle {
                border.color: "darkgrey"
                height: tabBar.height + 1
                border.width: 0
                color: tabBar.currentIndex === 4 ? "crimson" : "black"
            }
            Material.accent: "white"
        }
        TabButton {
            text: "Posts"
            background: Rectangle {
                border.color: "darkgrey"
                height: tabBar.height + 1
                border.width: 0
                color: tabBar.currentIndex === 5 ? "orange" : "black"
            }
            Material.accent: "black"
        }
        TabButton {
            text: "Discipline"
            background: Rectangle {
                border.color: "darkgrey"
                height: tabBar.height + 1
                border.width: 0
                color: tabBar.currentIndex === 6 ? "maroon" : "black"
            }
            Material.accent: "white"
        }
    }
    Rectangle {
        color: tabBackgroundColor
        anchors {
            top: tabBar.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }
        SwipeView {
            id: mainView
            interactive: false
            currentIndex: tabBar.currentIndex
            anchors {
                fill: parent
            }
            Pages.Schedule {

            }
            Pages.Absences {

            }
            Pages.Vacations {

            }

            Pages.Employes {

            }
            Pages.Productions {

            }
            Pages.Postes {

            }
            Pages.Discipline {

            }
        }
    }
}
