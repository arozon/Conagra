import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Item {

    property var nameModel
    property int currentId: -1

    function getInformation(id) {
        var obj = backend.getEmployeByID(id);
        console.log(JSON.stringify(obj));
        name.text = obj.nameEmploye;
        lastName.text = obj.lastNameEmploye;
        var d = Date.fromLocaleString(Qt.locale(), obj.hireDayEmploye, "dd-MM-yyyy");
        hireday.text = d.getDate();
        hiremonth.text = d.getMonth();
        hireyear.text = d.getFullYear();
        d = Date.fromLocaleString(Qt.locale(), obj.birthDayEmploye, "dd-MM-yyyy");
        birthday.text = d.getDate();
        birthmonth.text = d.getMonth();
        birthyear.text = d.getFullYear();
        employeNumber.text = obj.employeNumber;
        employeAnciennete.text = obj.ancienneteEmploye;
        eveningCheck.checked = obj.availableEvenings;
        dayCheck.checked = obj.availableDays;
        nightCheck.checked = obj.availableNights;
        wecCheck.checked = obj.availableWeekends;
        isAgencyCheck.checked = obj.isAgency;
        isInvalidCheck.checked = obj.isInvalid;
        var b;
        for (var i = 0; i < 7; i++) {
            b = (parseInt(obj.specificAvailability[i]) === 1 ? true : false);
            switch(i) {
            case 0:
                isMonday.checked = b;
                break;
            case 1:
                isTuesday.checked = b;
                break;
            case 2:
                isWednesday.checked = b;
                break;
            case 3:
                isThursday.checked = b;
                break;
            case 4:
                isFriday.checked = b;
                break;
            case 5:
                isSaturday.checked = b;
                break;
            case 6:
                isSunday.checked = b;
                break;
            }
        }

    }

    function fixDate() {
        // Fixes the date for parsing if its wrongly setup
        var day = parseInt(hireday.text);
        if (day < 10 && hireday.text.length < 2) hireday.text = "0" + hireday.text;
        day = parseInt(birthday.text);
        if (day < 10 && birthday.text.length < 2) birthday.text = "0" + birthday.text;

        var month = parseInt(hiremonth.text);
        if (month < 10 && hiremonth.text.length < 2) hiremonth.text = "0" + hiremonth.text;
        month = parseInt(birthmonth.text);
        if (month < 10 && birthmonth.text.length < 2) birthmonth.text = "0" + birthmonth.text;
    }

    function save() {
        if (name.text != "" && lastName.text != "") {
            fixDate();
            var obj = {}
            obj.nameEmploye = name.text;
            obj.lastNameEmploye = lastName.text;
            obj.hireDayEmploye = hireday.text+"-"+hiremonth.text+"-"+hireyear.text;
            obj.birthDayEmploye = birthday.text+"-"+birthmonth.text+"-"+birthyear.text;
            obj.employeNumber = parseInt(employeNumber.text);
            obj.ancienneteEmploye = parseInt(employeAnciennete.text);
            obj.availableEvenings = eveningCheck.checked;
            obj.availableDays = dayCheck.checked;
            obj.availableNights = nightCheck.checked;
            obj.availableWeekends = wecCheck.checked;
            obj.isAgency = isAgencyCheck.checked;
            obj.isInvalid = isInvalidCheck.checked;
            obj.specificAvailability = [isMonday.checked, isTuesday.checked, isWednesday.checked,
                                          isThursday.checked, isFriday.checked, isSaturday.checked, isSunday.checked];
            console.log(JSON.stringify(obj));
            backend.updateEmploye(obj, currentId);
        }
        var c = employeeCombo.currentIndex;
        nameModel = backend.getEmployeNamesAndID();
        employeeCombo.currentIndex = c;

    }

    ComboBox {
        id: employeeCombo
        textRole: "name"
        width: parent.width / 2 - anchors.rightMargin
        anchors.right: parent.right
        anchors.rightMargin: 10
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

    Item {
        clip: true
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.top: employeeCombo.bottom
        anchors.topMargin: 10
        Material.accent: "black"
        ScrollView {
            id: flickable
            contentHeight: button.y + button.height + 10
            anchors {
                fill: parent
            }

            Column {
                id: leftDevider
                spacing: 5
                anchors.rightMargin: parent.width / 2 + 10
                anchors.right: parent.right
                anchors.leftMargin: 20
                anchors {
                    left: parent.left

                }

                Label {
                    id: label
                    text: qsTr("Hire Date")
                    bottomPadding: 9
                    padding: 10
                    font.family: "Arial"
                    anchors.rightMargin: 20
                    anchors.right: parent.right
                    anchors.left: parent.left
                    horizontalAlignment: Text.AlignRight
                    font.pointSize: 16
                    topPadding: 20
                    verticalAlignment: Text.AlignVCenter
                }
                Label {
                    id: label1
                    text: qsTr("Date of Birth")
                    rightPadding: 10
                    font.capitalization: Font.Capitalize
                    horizontalAlignment: Text.AlignRight
                    bottomPadding: 13
                    verticalAlignment: Text.AlignVCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    padding: 10
                    anchors.left: parent.left
                    topPadding: 20
                    font.pointSize: 16
                    font.family: "Arial"
                }

                Rectangle {
                    height: name.height + 2 * name.anchors.margins
                    border.width: 1
                    border.color: "darkgrey"
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    TextField {
                        id: name
                        horizontalAlignment: Text.AlignRight
                        anchors {
                            fill: parent
                            margins: 5
                            leftMargin: 10
                            rightMargin: 10
                        }
                        placeholderText: "Name"
                        font.pointSize: 16
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
                    id: postCombo
                    displayText: "Poste"
                    flat: false
                    anchors.left: parent.left
                    anchors.right: parent.right
                }

                CheckBox {
                    id: eveningCheck
                    width: implicitWidth > parent.width ? parent.width : implicitWidth
                    text: "Available Evenings"
                    anchors.right: parent.right
                    font.pointSize: 16
                }
                CheckBox {
                    id: dayCheck
                    width: implicitWidth > parent.width ? parent.width : implicitWidth
                    text: "Available Days"
                    anchors.right: parent.right
                    font.pointSize: 16
                }

                CheckBox {
                    id: nightCheck
                    width: implicitWidth > parent.width ? parent.width : implicitWidth
                    text: "Available Nights"
                    anchors.right: parent.right
                    font.pointSize: 16
                }

                CheckBox {
                    id: wecCheck
                    width: implicitWidth > parent.width ? parent.width : implicitWidth
                    text: "Available Weekends"
                    anchors.right: parent.right
                    font.pointSize: 16
                }



            }

            Column {
                id: rightDevider
                spacing: 5
                anchors.leftMargin: parent.width / 2 + 10
                anchors.left: parent.left
                anchors.rightMargin: 20
                anchors {
                    right: parent.right
                }

                Item {
                    id: firstDatePicker
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
                            id: hireday

                        }
                        TextField {
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                            placeholderText: "Month"
                            id: hiremonth
                        }
                        TextField {
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                            placeholderText: "Year"
                            id: hireyear
                        }
                    }

                }

                Item {
                    id: firstDatePicker1
                    height: 50
                    anchors.right: parent.right
                    anchors.left: parent.left
                    RowLayout {
                        anchors.fill: parent
                        TextField {
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                            placeholderText: "Day"
                            id: birthday

                        }
                        TextField {
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                            placeholderText: "Month"
                            id: birthmonth
                        }
                        TextField {
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                            placeholderText: "Year"
                            id: birthyear
                        }
                    }
                }

                Rectangle {
                    height: lastName.height + 2 * lastName.anchors.margins
                    border.width: 1
                    border.color: "darkgrey"
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    TextField {
                        id: lastName
                        horizontalAlignment: Text.AlignRight
                        anchors {
                            fill: parent
                            margins: 5
                            leftMargin: 10
                            rightMargin: 10
                        }

                        font.pointSize: 16
                        placeholderText: "Last Name"
                    }
                }

                Rectangle {
                    height: employeNumber.height + 2 * employeNumber.anchors.margins
                    border.color: "#a9a9a9"
                    anchors.right: parent.right
                    anchors.left: parent.left
                    TextField {
                        id: employeNumber
                        height: 48
                        horizontalAlignment: Text.AlignRight
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        placeholderText: "Employe Number"
                        font.pointSize: 16
                        anchors.margins: 5
                        validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                    }
                    border.width: 1
                }

                Rectangle {
                    height: employeAnciennete.height + 2 * employeAnciennete.anchors.margins
                    border.color: "#a9a9a9"
                    anchors.right: parent.right
                    anchors.left: parent.left
                    TextField {
                        id: employeAnciennete
                        height: 48
                        horizontalAlignment: Text.AlignRight
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        placeholderText: "Anciennete"
                        font.pointSize: 16
                        anchors.margins: 5
                        validator: RegExpValidator { regExp: /[0-9A-F]+/ }
                    }
                    border.width: 1
                }

                CheckBox {
                    id: isAgencyCheck
                    width: implicitWidth > parent.width ? parent.width : implicitWidth
                    text: "Is from Agency"
                    font.pointSize: 16
                    anchors.right: parent.right
                }

                CheckBox {
                    id: hasHoursCheck
                    width: implicitWidth > parent.width ? parent.width : implicitWidth
                    text: "Has over 2000 Hours"
                    anchors.right: parent.right
                    font.pointSize: 16
                }

                CheckBox {
                    id: isInvalidCheck
                    width: implicitWidth > parent.width ? parent.width : implicitWidth
                    text: "Is Invalid"
                    anchors.right: parent.right
                    font.pointSize: 16
                }




            }

            GroupBox {
                id: groupBox
                height: flow1.childrenRect.height + 60
                font.pointSize: 16
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.top: leftDevider.bottom
                anchors.topMargin: 10
                title: qsTr("Specifique Availabilities")

                Flow {
                    id: flow1
                    flow: Flow.LeftToRight
                    spacing: 10
                    layoutDirection: Qt.LeftToRight
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    anchors.topMargin: 0

                    CheckBox {
                        id: isMonday
                        text: "Monday"
                    }

                    CheckBox {
                        id: isTuesday
                        text: "Tuesday"
                    }

                    CheckBox {
                        id: isWednesday
                        text: "Wednesday"
                    }

                    CheckBox {
                        id: isThursday
                        text: "Thursday"
                    }

                    CheckBox {
                        id: isFriday
                        text: "Friday"
                    }

                    CheckBox {
                        id: isSaturday
                        text: "Saturday"
                    }

                    CheckBox {
                        id: isSunday
                        text: "Sunday"
                    }
                }
            }

            GroupBox {
                id: groupBox1
                height: 300
                font.pointSize: 16
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.top: groupBox.bottom
                anchors.topMargin: 10
                title: qsTr("Work Restrictions")

                RowLayout {
                    id: rowLayout
                    height: 50
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0

                    ComboBox {
                        id: postRestrictionsCombo
                        Layout.fillWidth: true
                        displayText: "Poste"
                    }

                    Button {
                        id: postAddRestrictionButton
                        text: qsTr("Add Restriction")
                        Material.foreground: "white"
                        Material.background: Material.BlueGrey
                    }
                }
                Rectangle {
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    border.width: 1
                    border.color: "darkgrey"
                    anchors.top: rowLayout.bottom
                    anchors.topMargin: 5
                    ListView {
                        id: listView
                        anchors {
                            fill: parent
                            margins: 5
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
            }

            Button {
                id: button
                x: 506
                enabled: currentId != -1 ? true : false
                text: qsTr("Save")
                font.pointSize: 16
                anchors.topMargin: 10
                anchors.top: groupBox1.bottom
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
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
