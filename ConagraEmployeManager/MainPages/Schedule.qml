import QtQuick 2.11
import QtQuick.Controls.Material 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {

    Item {
        id: header
        height: 50
        anchors {
            leftMargin: 8
            rightMargin: 8
            topMargin: 4
            left: parent.left
            right: parent.right
            top: parent.top
        }

        RowLayout {
            ComboBox {
                model: ["Pogo","Sauce"]
            }

            ComboBox {
                model: ["Day", "Evening"]
            }

            ComboBox {
                model: ["Daily", "Weekly", "Montly"]
            }

            Item {
                id: datePicker
                Layout.maximumWidth: 100
                Layout.minimumWidth: 100
                Layout.maximumHeight: parent.implicitHeight
                Layout.minimumHeight: parent.implicitHeight
                RowLayout {
                    anchors {
                        fill: parent
                    }

                    ComboBox {
                        model: 31
                        Layout.fillWidth: true

                    }
                    ComboBox {
                        model: 12
                        Layout.fillWidth: true
                    }
                    ComboBox {
                        model: 5
                        Layout.fillWidth: true
                    }
                }

            }
        }
    }

    Pane {
        anchors {
            margins: 8
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: footer.top
        }
        Material.elevation: 8
        Material.background: "white"
    }

    Item {
        id: footer
        height: 20
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }



}
