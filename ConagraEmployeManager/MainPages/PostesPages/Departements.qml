import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Item {

    RowLayout {
        height: 70
        anchors {
            rightMargin: 20
            right: parent.right
            left: parent.left
            topMargin: 20
            leftMargin: 20
            top: parent.top
        }

        Rectangle {
            height: departmentName.height + 2 * departmentName.anchors.margins
            Layout.fillWidth: true
            border.color: "#a9a9a9"
            TextField {
                id: departmentName
                height: 48
                horizontalAlignment: Text.AlignRight
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                placeholderText: "Department Name"
                font.pointSize: 20
                anchors.margins: 5
            }
            border.width: 1
        }
        Button {
            text: "Add"
            Layout.maximumHeight: implicitHeight
            Layout.maximumWidth: implicitWidth
            Layout.minimumHeight: implicitHeight
            Layout.minimumWidth: implicitWidth
            Layout.fillHeight: false
            Layout.fillWidth: false

        }
    }

    ListView {
        id: listView
        x: 0
        y: 0
        width: 110
        height: 160
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
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
                spacing: 10
            }
        }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
