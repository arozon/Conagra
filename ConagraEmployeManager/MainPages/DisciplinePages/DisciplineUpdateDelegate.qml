import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3

Rectangle {
    clip:true
    Material.accent: "black"
    property int labelSize: 14
    property int marg: 10
    id: rectangle
    height: col.height
    color: "#ededed"
    width: parent.width
    border.color: "darkgray"
    border.width: 1
    radius: 3

    signal checked(var ind);
    Connections {
        target: updat
        onIsChecked: {
            if (index != inde) {
                checkDelegate.checked = false;
            }else {
                checkDelegate.checked = true;
            }
        }
    }

    CheckDelegate {
        id: checkDelegate
        width: 60
        height: 60
        checkable: false
        anchors {
            left: parent.left
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }
    }

    Column {
        id: col
        anchors {

            topMargin: marg
            top: parent.top
            left: checkDelegate.right
            right: parent.right
        }

        height: subCol.height + subCol.y + 2*marg
        Row {
            Label {
                text: "Category:"
                font.bold: true
                rightPadding: 10
                padding: 3
                font.pointSize: labelSize
            }
            Label {
                text: model.modelData.category
                padding: 3
                font.pointSize: labelSize
            }
        }
        Row {
            Label {
                text: "Action taken:"
                font.bold: true
                rightPadding: 10
                padding: 3
                font.pointSize: labelSize
            }
            Label {
                text: model.modelData.action
                padding: 3
                font.pointSize: labelSize
            }
        }
        Row {
            Label {
                text: "Date:"
                font.bold: true
                rightPadding: 10
                padding: 3
                font.pointSize: labelSize
            }
            Label {
                text: model.modelData.date
                padding: 3
                font.pointSize: labelSize
            }
        }
        Row {
            Label {
                text: "Supervisor:"
                font.bold: true
                rightPadding: 10
                padding: 3
                font.pointSize: labelSize
            }
            Label {
                text: model.modelData.supervisor
                padding: 3
                font.pointSize: labelSize
            }
        }
        Column {
            id: subCol
            height: subLabel.height + subLabel.y
            Label {
                text: "Comment"
                font.bold: true
                padding: 3
                font.pointSize: labelSize
            }
            Label {
                id: subLabel
                text: model.modelData.comment
                wrapMode: Text.WordWrap
                padding: 3
                leftPadding: 15
                font.pointSize: labelSize -1;
            }
        }
    }
    MouseArea {
        anchors {
            fill: parent
        }
        onClicked: {
            checkDelegate.checked = !checkDelegate.checked
            checked(index);
        }
    }
}
