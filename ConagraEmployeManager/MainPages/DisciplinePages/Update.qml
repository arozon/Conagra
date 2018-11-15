import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Item {
    id: updat
    property var nameModel
    property var listModel
    property int currentId: -1
    property int employeId: -1
    signal isChecked(var inde);

    onIsChecked: {
        //Change info based on the current index and set global index to inde...
        var obj = listModel[inde];
        currentId = obj.id;
        employeId = obj.idEmploye;
        categoryText.text = obj.category;
        supervisorText.text = obj.supervisor;
        commentText.text = obj.comment;
        actionText.text = obj.action;
        //Set department, quart, employe id
        var d = Date.fromLocaleString(Qt.locale(),obj.date, "dd-MM-yyyy");
        disday.text = d.getDate().toString();
        dismonth.text = (d.getMonth() + 1).toString();
        disyear.text = d.getFullYear().toString();
    }

    function fixDate() {
        // Fixes the date for parsing if its wrongly setup
        var day = parseInt(disday.text);
        if (day < 10 && disday.text.length < 2) disday.text = "0" + disday.text;

        var month = parseInt(dismonth.text);
        if (month < 10 && dismonth.text.length < 2) dismonth.text = "0" + dismonth.text;
    }

    function getInformation(id) {
        listModel = backend.getDisciplinaryMesures(id);
        console.log(JSON.stringify(listModel));
    }

    function save() {
        fixDate();
        var obj = {};
        obj.id = currentId;
        obj.idEmploye = employeId;
        obj.idQuart = -1;
        obj.idDepartement = -1;
        obj.category = categoryText.text;
        obj.supervisor = supervisorText.text;
        obj.comment = commentText.text;
        obj.action = actionText.text;
        obj.mesureDate = disday.text+"-"+dismonth.text+"-"+disyear.text;
        console.log(JSON.stringify(obj));
        console.log(backend.updateDisciplinaryMesure(obj, currentId));
        listModel = backend.getDisciplinaryMesures(employeId);
    }

    ScrollView {
        id: view
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
                    getInformation(id);
                }

                onCurrentIndexChanged: {
                    var id = model[currentIndex].id;
                    currentId = id;
                    getInformation(id);
                }

            }

            Rectangle {
                clip:true
                id: rectangle
                height: 300
                color: "#ffffff"
                border.width: 1
                border.color: "darkgray"
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.leftMargin: 0

                ListView {

                    id: listView
                    antialiasing: true
                    anchors {
                        margins: 10
                        fill: parent

                    }
                    spacing: 5
                    delegate: DisciplineUpdateDelegate {
                        onChecked: {
                            isChecked(ind);
                        }
                    }
                    model: listModel
                }
            }

            Item {
                id: datePicker
                height: 50
                anchors.left: parent.left
                anchors.right: parent.right
                Label {
                    id: dateLabel
                    text: "Disciplinary action Date"
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
                height: categoryText.height + 2 * categoryText.anchors.margins
                border.width: 1
                border.color: "darkgrey"
                anchors {
                    left: parent.left
                    right: parent.right
                }
                TextField {
                    id: categoryText
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
                height: supervisorText.height + 2 * supervisorText.anchors.margins
                border.width: 1
                border.color: "darkgrey"
                anchors {
                    left: parent.left
                    right: parent.right
                }
                TextField {
                    id: supervisorText
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
                height: actionText.height + 2 * actionText.anchors.margins
                border.width: 1
                border.color: "darkgrey"
                anchors {
                    left: parent.left
                    right: parent.right
                }
                TextField {
                    id: actionText
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
                    id: commentText
                    height: 140
                    text: qsTr("")
                    rightPadding: 5
                    leftPadding: 5
                    font.pointSize: 20
                    placeholderText: "Comments on the disciplinary action taken"
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
            text: qsTr("Save")
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

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:24;anchors_height:160;anchors_width:110;anchors_x:0;anchors_y:210}
D{i:34;anchors_width:200}
}
 ##^##*/
