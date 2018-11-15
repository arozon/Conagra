import QtQuick 2.11
import QtQuick.Controls.Material 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {

    Material.accent: "black"
    property int currentId: -1
    property var nameModel

    function fixDate() {
        // Fixes the date for parsing if its wrongly setup
        var day = parseInt(startday.text);
        if (day < 10 && startday.text.length < 2) startday.text = "0" + startday.text;
        day = parseInt(endday.text);
        if (day < 10 && endday.text.length < 2) endday.text = "0" + endday.text;

        var month = parseInt(startmonth.text);
        if (month < 10 && startmonth.text.length < 2) startmonth.text = "0" + startmonth.text;
        month = parseInt(endmonth.text);
        if (month < 10 && endmonth.text.length < 2) endmonth.text = "0" + endmonth.text;
    }

    function save() {
        fixDate();
        var obj = {};
        obj.idEmploye = currentId;
        obj.startDate = startday.text + "-" + startmonth.text + "-" + startyear.text;
        obj.endDate = endday.text + "-" + endmonth.text + "-" + endyear.text;
        obj.useRange = useRangeCheck.checked;
        obj.lateAbsence = lateCheck.checked;
        obj.lateTime = parseInt(lateMinutes.text);
        obj.earlyAbsence = earlyCheck.checked;
        obj.earlyTime = parseInt(earlyMinutes.text);
        obj.isPlanned = plannedCheck.checked;
        obj.useCA = useCa.checked;
        console.log(JSON.stringify(obj));
        console.log(backend.addAbsence(obj));

    }

    ScrollView {
        id: flickable
        contentHeight: rect.height + 10 + rect.y
        anchors {
            fill: parent
        }

        Column {
            id: leftDevider
            anchors.rightMargin: parent.width / 2 + 10
            anchors.right: parent.right
            anchors.leftMargin: 20
            anchors {
                left: parent.left

            }

            Label {
                id: label
                text: qsTr("Day of week")
                anchors.rightMargin: 20
                anchors.right: parent.right
                anchors.left: parent.left
                horizontalAlignment: Text.AlignRight
                font.pointSize: 23
                topPadding: 62
                verticalAlignment: Text.AlignVCenter
            }

            CheckBox {
                id: lateCheck
                text: qsTr("Late Absence")
                anchors.left: parent.left
                anchors.leftMargin: 30
                font.pointSize: 22
            }
            Rectangle {
                height: lateMinutes.height + 2 * lateMinutes.anchors.margins
                visible: lateCheck.checked
                border.width: 1
                border.color: "darkgrey"
                anchors {
                    left: parent.left
                    leftMargin: 20
                    right: parent.right
                    rightMargin: 20
                }
                TextField {
                    id: lateMinutes
                    horizontalAlignment: Text.AlignRight

                    anchors {
                        fill: parent
                        margins: 5
                        leftMargin: 10
                        rightMargin: 10
                    }

                    font.pointSize: 20
                    placeholderText: "Time in Minutes"
                }
            }

            CheckBox {
                id: earlyCheck
                text: qsTr("Early Absence")
                anchors.left: parent.left
                anchors.leftMargin: 30
                font.pointSize: 22
            }

            Rectangle {
                height: earlyMinutes.height + 2 * earlyMinutes.anchors.margins
                visible: earlyCheck.checked
                border.width: 1
                border.color: "darkgrey"
                anchors {
                    left: parent.left
                    leftMargin: 20
                    right: parent.right
                    rightMargin: 20
                }
                TextField {
                    id: earlyMinutes
                    horizontalAlignment: Text.AlignRight
                    anchors {
                        fill: parent
                        margins: 5
                        leftMargin: 10
                        rightMargin: 10
                    }
                    validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                    placeholderText: "Time in Minutes"
                    font.pointSize: 20
                }
            }

        }

        Column {
            id: rightDevider
            anchors.leftMargin: parent.width / 2 + 10
            anchors.left: parent.left
            anchors.rightMargin: 20
            anchors {
                right: parent.right
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
                id: startDatePicker
                height: 50
                anchors.right: parent.right
                anchors.left: parent.left
                RowLayout {
                    anchors {
                        fill: parent
                    }

                    TextField {
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillWidth: true
                        validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                        placeholderText: "Day"
                        id: startday

                    }
                    TextField {
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillWidth: true
                        validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                        placeholderText: "Month"
                        id: startmonth
                    }
                    TextField {
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillWidth: true
                        validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                        placeholderText: "Year"
                        id: startyear
                    }
                }

            }
            Item {
                id: endDatePicker
                height: 50
                anchors.right: parent.right
                anchors.left: parent.left
                visible: useRangeCheck.checked
                RowLayout {
                    anchors {
                        fill: parent
                    }

                    TextField {
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillWidth: true
                        validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                        placeholderText: "Day"
                        id: endday

                    }
                    TextField {
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillWidth: true
                        validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                        placeholderText: "Month"
                        id: endmonth
                    }
                    TextField {
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillWidth: true
                        validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                        placeholderText: "Year"
                        id: endyear
                    }
                }

            }
            Item {
                id: secondDatePicker
                height: 50
                anchors.right: parent.right
                anchors.left: parent.left
                visible: useRangeCheck.checked
                RowLayout {
                    anchors.rightMargin: 20
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

            CheckBox {
                id: useRangeCheck
                text: qsTr("Use a date range")
                font.pointSize: 22
                display: AbstractButton.IconOnly
            }

            CheckBox {
                id: plannedCheck
                text: qsTr("Planned Absence")
                font.pointSize: 22
            }

            CheckBox {
                id: useCa
                text: qsTr("Use Credited Absence")
                font.pointSize: 22
            }

        }

        Rectangle {
            id: rect
            border.color: "darkgrey"
            border.width: 1
            anchors {
                rightMargin: 20
                right: parent.right
                left: parent.left
                topMargin: 20
                leftMargin: 20
                top: rightDevider.height > leftDevider.height ? rightDevider.bottom : leftDevider.bottom
            }
            height: 150

            TextArea {
                id: textArea
                height: 140
                text: qsTr("")
                rightPadding: 5
                leftPadding: 5
                font.pointSize: 20
                placeholderText: "Comments on the absence"
                anchors {
                    fill: parent
                    margins: 5
                    leftMargin: 20
                    rightMargin: 20
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
            anchors.top: rect.bottom
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
    D{i:0;autoSize:true;height:480;width:640}D{i:30;anchors_width:320}D{i:39;anchors_width:320}
}
 ##^##*/
