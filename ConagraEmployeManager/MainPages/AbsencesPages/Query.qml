import QtQuick 2.11
import QtQuick.Controls.Material 2.2
import QtQuick.Controls 2.2
import QtCharts 2.2
import QtQuick.Layouts 1.3

Item {
    ScrollView {
        id: flickable
        contentHeight: rect.height + 20 + rect.y
        anchors {
            fill: parent
        }

        Column {
            id: leftDevider
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.rightMargin: parent.width / 2 + 10
            anchors.right: parent.right
            anchors.leftMargin: 20
            anchors.left: parent.left
            Item {
                id: firstDatePicker
                height: 50
                anchors.right: parent.right
                anchors.left: parent.left
                RowLayout {
                    anchors {
                        fill: parent
                    }

                    Label {
                        Layout.maximumWidth: implicitWidth
                        font.pointSize: 22
                        text: "From :"
                    }

                    ComboBox {
                        model: ["June", "July"]
                        Layout.fillWidth: true
                    }
                    ComboBox {
                        model: 5
                        Layout.fillWidth: true
                    }
                }

            }
            Item {
                id: secondDatePicker
                height: 50
                anchors.right: parent.right
                anchors.left: parent.left
                RowLayout {
                    anchors {
                        fill: parent
                    }

                    Label {
                        Layout.maximumWidth: implicitWidth
                        font.pointSize: 22
                        text: "To :"
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

            ChartView {
                id: creditsChart
                anchors.left: parent.left
                anchors.right: parent.right
                height: 400
                title: "Absence credits"
                titleFont.pointSize: 22
                titleFont.bold: true
                backgroundColor: Qt.rgba(0,0,0,0)
                //legend.visible: false
                antialiasing: true
                PieSeries {
                    id: creditSeries
                    PieSlice {
                        label: "Taken";
                        value: 35;
                        labelPosition: PieSlice.LabelInsideHorizontal;
                        labelVisible: true;
                        labelColor: "white"
                    }
                    PieSlice {
                        label: "Remaining";
                        value: 65;
                        exploded: true;
                        labelPosition: PieSlice.LabelInsideHorizontal;
                        labelVisible: true;
                        labelColor: "white";
                    }
                }
            }
        }
        Column {
            id: rightDevider
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.rightMargin: 20
            anchors.leftMargin: parent.width / 2 + 10
            anchors.left: parent.left
            anchors.right: parent.right

            ComboBox {
                width: parent.width - anchors.rightMargin
                anchors.right: parent.right
                anchors.rightMargin: 10
                editable: true
                displayText: "Employe Name"

            }

            ChartView {
                title: "Credits taken per Month"
                backgroundColor: Qt.rgba(0,0,0,0)
                titleFont.pointSize: 22
                titleFont.bold: true
                anchors {
                    left: parent.left
                    right: parent.right
                }
                height: 450

                //legend.alignment: Qt.AlignBottom
                antialiasing: true

                BarSeries {
                    id: mySeries
                    axisX: BarCategoryAxis { categories: ["Jun.", "Jul.", "Aug.", "Sept.", "Octo.", "Nov." ] }
                    BarSet { label: "Bob"; values: [2, 2, 3, 4, 5, 6] }
                    BarSet { label: "Susan"; values: [5, 1, 2, 4, 1, 7] }
                    BarSet { label: "James"; values: [3, 5, 8, 13, 5, 8] }
                }
            }

        }
        Rectangle {
            id: rect
            border.color: "darkgrey"
            border.width: 1
            anchors.topMargin: 10
            anchors.top: leftDevider.height > rightDevider.height ? leftDevider.bottom : rightDevider.bottom
            anchors.rightMargin: 20
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.leftMargin: 20
            height: 300
            Loader {
                anchors {
                    fill: parent
                    margins: 5
                }

                asynchronous: true
                active: true
                sourceComponent: comp
            }
            Component {
                id: comp
                ListView {
                    id: listView
                    delegate: Item {
                        x: 5
                        width: 80
                        height: 40
                        Row {
                            id: row1
                            Rectangle {
                                width: 40
                                height: 40
                                color: colorCode
                            }

                            Text {
                                text: name
                                font.bold: true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            spacing: 10
                        }
                    }
                    model: ListModel {
                        ListElement {
                            name: "Grey"
                            colorCode: "grey"
                        }

                        ListElement {
                            name: "Red"
                            colorCode: "red"
                        }

                        ListElement {
                            name: "Blue"
                            colorCode: "blue"
                        }

                        ListElement {
                            name: "Green"
                            colorCode: "green"
                        }
                    }
                }
            }
        }

    }

}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:44;anchors_width:110;anchors_x:0;anchors_y:0}
}
 ##^##*/
