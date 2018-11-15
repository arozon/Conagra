import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Item {

    property var nameModel
    property int currentId: -1

    function fixDate() {
        // Fixes the date for parsing if its wrongly setup
        var day = parseInt(disday.text);
        if (day < 10 && disday.text.length < 2) disday.text = "0" + disday.text;

        var month = parseInt(dismonth.text);
        if (month < 10 && dismonth.text.length < 2) dismonth.text = "0" + dismonth.text;
    }

    function getInformation() {

    }

    function save() {
        fixDate();
        var obj = {};
        obj.idEmploye = currentId;
        obj.idQuart = -1;
        obj.idDepartement = -1;
        obj.category = category.text;
        obj.supervisor = supervisor.text;
        obj.comment = comment.text;
        obj.action = action.text;
        obj.mesureDate = disday.text+"-"+dismonth.text+"-"+disyear.text;
        console.log(JSON.stringify(obj));
        console.log(backend.addDisciplinaryMesure(obj));
    }

    ScrollView {
        contentHeight: button.y + button.height + 10
        contentWidth: width
        anchors {
            fill:parent
            margins: 10
        }

        Column {
            id: column
            spacing: 10
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                leftMargin: 20
                rightMargin: 20
            }

            ComboBox {
                id: employeeCombo
                textRole: "name"
                width: parent.width / 2 - anchors.rightMargin
                anchors.right: parent.right
                anchors.rightMargin: 0
                editable: true
                displayText: "Employe Name"
                model: nameModel

                onAccepted: {
                    var id = model[currentIndex].id;
                    currentId = id;
                    //getInformation(id);
                }

                onCurrentIndexChanged: {
                    var id = model[currentIndex].id;
                    currentId = id;
                    //getInformation(id);
                }

            }
            Item {
                id: datePicker
                height: 50
                anchors.left: parent.left
                anchors.right: parent.right
                Label {
                    id: dateLabel
                    text: "Disciplinary Action Date"
                    rightPadding: 15
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    font.pointSize: 18
                }

                RowLayout {
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.left: dateLabel.right

                    TextField {
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillWidth: true
                        validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                        placeholderText: "Day"
                        id: disday

                    }
                    TextField {
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillWidth: true
                        validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                        placeholderText: "Month"
                        id: dismonth
                    }
                    TextField {
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillWidth: true
                        validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                        placeholderText: "Year"
                        id: disyear
                    }
                }

            }
            ComboBox {
                id: depCombo
                displayText: "Department"
                flat: false
                anchors.left: parent.left
                anchors.right: parent.right
            }
            ComboBox {
                id: quartCombo
                displayText: "Quart"
                flat: false
                anchors.left: parent.left
                anchors.right: parent.right
            }



            Rectangle {
                height: category.height + 2 * category.anchors.margins
                border.width: 1
                border.color: "darkgrey"
                anchors {
                    left: parent.left
                    right: parent.right
                }
                TextField {
                    id: category
                    horizontalAlignment: Text.AlignRight
                    anchors {
                        fill: parent
                        margins: 5
                        leftMargin: 10
                        rightMargin: 10
                    }
                    placeholderText: "Category"
                    font.pointSize: 16
                }
            }

            Rectangle {
                height: supervisor.height + 2 * supervisor.anchors.margins
                border.width: 1
                border.color: "darkgrey"
                anchors {
                    left: parent.left
                    right: parent.right
                }
                TextField {
                    id: supervisor
                    horizontalAlignment: Text.AlignRight
                    anchors {
                        fill: parent
                        margins: 5
                        leftMargin: 10
                        rightMargin: 10
                    }
                    placeholderText: "Supervisor"
                    font.pointSize: 16
                }
            }
            Rectangle {
                height: action.height + 2 * action.anchors.margins
                border.width: 1
                border.color: "darkgrey"
                anchors {
                    left: parent.left
                    right: parent.right
                }
                TextField {
                    id: action
                    horizontalAlignment: Text.AlignRight
                    anchors {
                        fill: parent
                        margins: 5
                        leftMargin: 10
                        rightMargin: 10
                    }
                    placeholderText: "Actions"
                    font.pointSize: 16
                }
            }
            Rectangle {
                id: rect
                border.color: "darkgrey"
                border.width: 1
                anchors {
                    right: parent.right
                    left: parent.left
                }
                height: 150

                TextArea {
                    id: comment
                    height: 140
                    text: qsTr("")
                    rightPadding: 5
                    leftPadding: 5
                    font.pointSize: 20
                    placeholderText: "Comments on the disciplinary actions taken"
                    anchors {
                        fill: parent
                        margins: 5
                        leftMargin: 20
                        rightMargin: 20
                    }
                }
            }
        }
        Button {
            id: button
            x: 506
            enabled: currentId > -1
            text: qsTr("Add Employe")
            font.pointSize: 16
            anchors.topMargin: 10
            anchors.top: column.bottom
            anchors.rightMargin: 20
            anchors.right: parent.right
            Material.background: Material.BlueGrey
            Material.foreground: "white"
            onClicked: {
                save();
            }
        }
    }

}
