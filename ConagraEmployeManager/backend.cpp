#include "backend.h"
#include "employenameid.h"
#include "disciplinarymesuremodel.h"



Backend::Backend(QObject *parent) : QObject(parent)
{


}

Backend::Backend(QSqlDatabase database, QObject *parent) : QObject (parent) {
    db = database;
}

bool Backend::addEmploye(const QJsonObject &employe)
{
    QSqlTableModel model;
    model.setTable("Employe");
    model.select();

    bool exists = false;
    for (int i = 0; i < model.rowCount(); i++) {
        QSqlRecord rec = model.record(i);
        if (rec.value(1).toString() == employe.value("nameEmploye").toString() &&
                rec.value(2).toString() == employe.value("lastNameEmploye").toString()) exists = true;
    }

    if (!exists) {

        int rowindex = model.rowCount();
        model.insertRow(rowindex);

        model.setData(model.index(rowindex, 1), employe.value("nameEmploye").toString());
        model.setData(model.index(rowindex, 2), employe.value("lastNameEmploye").toString());
        model.setData(model.index(rowindex, 3), QDate::fromString(employe.value("birthDayEmploye").toString(), "dd-MM-yyyy"));
        model.setData(model.index(rowindex, 4), QDate::fromString(employe.value("hireDayEmploye").toString(), "dd-MM-yyyy"));
        model.setData(model.index(rowindex, 5), employe.value("employeNumber").toInt());
        model.setData(model.index(rowindex, 6), employe.value("ancienneteEmploye").toInt());
        model.setData(model.index(rowindex, 7), employe.value("departmentId").toInt());
        model.setData(model.index(rowindex, 8), employe.value("posteId").toInt());
        model.setData(model.index(rowindex, 9), employe.value("availableEvenings").toBool());
        model.setData(model.index(rowindex, 10), employe.value("availableDays").toBool());
        model.setData(model.index(rowindex, 11), employe.value("availableNights").toBool());
        model.setData(model.index(rowindex, 12), employe.value("availableWeekends").toBool());
        model.setData(model.index(rowindex, 13), employe.value("isAgency").toBool());
        model.setData(model.index(rowindex, 14), employe.value("isInvalid").toBool());


        QJsonArray array = employe.value("specificAvailability").toArray();
        QString str;
        for (int i = 0; i < array.count(); i++) {
            if (i == 0) str.append(QString::number(array[i].toBool())); else str.append(";" + QString::number(array[i].toBool()));
        }

        model.setData(model.index(rowindex, 15), str);
        model.submitAll();
    }

    return !exists;
}

QVariant Backend::getEmployeNamesAndID()
{
    QSqlTableModel smodel;
    smodel.setTable("Employe");
    smodel.sort(2,Qt::SortOrder::AscendingOrder);
    smodel.select();

    QList<QObject*> list;
    for(int i = 0; i < smodel.rowCount(); i++) {
        QSqlRecord rec = smodel.record(i);
        list.append(new EmployeNameID(rec.value(2).toString() + ", " + rec.value(1).toString(),rec.value(0).toInt()));
    }
    return QVariant::fromValue(list);
}

QJsonObject Backend::getEmployeByID(const int &id)
{
    QSqlTableModel smodel;
    smodel.setTable("Employe");
    smodel.setFilter("idEmploye = " + QString::number(id));
    smodel.select();
    qDebug() << smodel.rowCount();
    QSqlRecord rec = smodel.record(0);
    QJsonDocument doc = QJsonDocument::fromJson(QString("{}").toUtf8());
    QJsonObject obj = doc.object();
    obj["nameEmploye"] = rec.value(1).toString();
    obj["lastNameEmploye"] = rec.value(2).toString();
    obj["birthDayEmploye"] = rec.value(3).toDate().toString("dd-MM-yyyy");
    obj["hireDayEmploye"] = rec.value(4).toDate().toString("dd-MM-yyyy");
    obj["employeNumber"] = rec.value(5).toInt();
    obj["ancienneteEmploye"] = rec.value(6).toInt();
    obj["departmentId"] = rec.value(7).toInt();
    obj["posteId"] = rec.value(8).toInt();
    obj["availableEvenings"] = rec.value(9).toBool();
    obj["availableNights"] = rec.value(10).toBool();
    obj["availableWeekends"] = rec.value(11).toBool();
    obj["availableDays"] = rec.value(12).toBool();
    obj["isAgency"] = rec.value(13).toBool();
    obj["isInvalid"] = rec.value(14).toBool();

    QJsonArray ar;
    QStringList str = rec.value(15).toString().split(";");
    for (int i = 0; i < str.length(); i++) {
        ar.append(str[i]);
    }
    obj["specificAvailability"] = ar;

    return obj;
}

bool Backend::updateEmploye(const QJsonObject &employe, const int &id)
{
    QSqlTableModel smodel;
    smodel.setTable("Employe");
    smodel.setFilter("idEmploye = " + QString::number(id));
    smodel.select();

    int rowindex = 0;

    smodel.setData(smodel.index(rowindex, 1), employe.value("nameEmploye").toString());
    smodel.setData(smodel.index(rowindex, 2), employe.value("lastNameEmploye").toString());
    smodel.setData(smodel.index(rowindex, 3), QDate::fromString(employe.value("birthDayEmploye").toString(), "dd-MM-yyyy"));
    smodel.setData(smodel.index(rowindex, 4), QDate::fromString(employe.value("hireDayEmploye").toString(), "dd-MM-yyyy"));
    smodel.setData(smodel.index(rowindex, 5), employe.value("employeNumber").toInt());
    smodel.setData(smodel.index(rowindex, 6), employe.value("ancienneteEmploye").toInt());
    smodel.setData(smodel.index(rowindex, 7), employe.value("departmentId").toInt());
    smodel.setData(smodel.index(rowindex, 8), employe.value("posteId").toInt());
    smodel.setData(smodel.index(rowindex, 9), employe.value("availableEvenings").toBool());
    smodel.setData(smodel.index(rowindex, 10), employe.value("availableDays").toBool());
    smodel.setData(smodel.index(rowindex, 11), employe.value("availableNights").toBool());
    smodel.setData(smodel.index(rowindex, 12), employe.value("availableWeekends").toBool());
    smodel.setData(smodel.index(rowindex, 13), employe.value("isAgency").toBool());
    smodel.setData(smodel.index(rowindex, 14), employe.value("isInvalid").toBool());


    QJsonArray array = employe.value("specificAvailability").toArray();
    QString str;
    for (int i = 0; i < array.count(); i++) {
        if (i == 0) str.append(QString::number(array[i].toBool())); else str.append(";" + QString::number(array[i].toBool()));
    }

    smodel.setData(smodel.index(rowindex, 15), str);
    return smodel.submitAll();
}

bool Backend::addDisciplinaryMesure(const QJsonObject &mesure)
{
    QSqlTableModel smodel;
    smodel.setTable("DisciplinaryMesures");
    smodel.select();

    int rowindex = smodel.rowCount();
    smodel.insertRow(rowindex);

    smodel.setData(smodel.index(rowindex, 1), mesure.value("idEmploye").toInt());
    smodel.setData(smodel.index(rowindex, 2), mesure.value("idQuart").toInt());
    smodel.setData(smodel.index(rowindex, 3), mesure.value("idDepartement").toInt());
    smodel.setData(smodel.index(rowindex, 4), mesure.value("category").toString());
    smodel.setData(smodel.index(rowindex, 5), mesure.value("supervisor").toString());
    smodel.setData(smodel.index(rowindex, 6), mesure.value("comment").toString());
    smodel.setData(smodel.index(rowindex, 7), mesure.value("action").toString());
    smodel.setData(smodel.index(rowindex, 8), QDate::fromString(mesure.value("mesureDate").toString(), "dd-MM-yyyy"));

    return smodel.submitAll();

}

QVariant Backend::getDisciplinaryMesures(const int &id)
{
    QList<QObject*> objects;
    QSqlTableModel smodel;
    smodel.setTable("DisciplinaryMesures");
    smodel.setFilter("idEmploye = " + QString::number(id));
    smodel.select();

    for (int i = 0; i < smodel.rowCount(); i++) {
        QSqlRecord rec = smodel.record(i);
        objects.append(new DisciplinaryMesureModel(
                           rec.value(0).toInt(),
                           rec.value(1).toInt(),
                           rec.value(2).toInt(),
                           rec.value(3).toInt(),
                           rec.value(4).toString(),
                           rec.value(5).toString(),
                           rec.value(6).toString(),
                           rec.value(7).toString(),
                           rec.value(8).toDate().toString("dd-MM-yyyy")
                           ));

    }

    return QVariant::fromValue(objects);
}

bool Backend::updateDisciplinaryMesure(const QJsonObject &mesure, const int &id)
{
    QSqlTableModel smodel;
    smodel.setTable("DisciplinaryMesures");
    smodel.setFilter("idDisciplinaryMesures = " + QString::number(id));
    smodel.select();

    smodel.setData(smodel.index(0, 1), mesure.value("idEmploye").toInt());
    smodel.setData(smodel.index(0, 2), mesure.value("idQuart").toInt());
    smodel.setData(smodel.index(0, 3), mesure.value("idDepartement").toInt());
    smodel.setData(smodel.index(0, 4), mesure.value("category").toString());
    smodel.setData(smodel.index(0, 5), mesure.value("supervisor").toString());
    smodel.setData(smodel.index(0, 6), mesure.value("comment").toString());
    smodel.setData(smodel.index(0, 7), mesure.value("action").toString());
    smodel.setData(smodel.index(0, 8), QDate::fromString(mesure.value("mesureDate").toString(), "dd-MM-yyyy"));

    return smodel.submitAll();
}

bool Backend::addAbsence(const QJsonObject &absence)
{
    QSqlTableModel smodel;
    smodel.setTable("Absences");
    smodel.select();

    int row = smodel.rowCount();
    smodel.insertRow(row);
    smodel.setData(smodel.index(row, 1), absence.value("idEmploye").toInt());
    smodel.setData(smodel.index(row, 2), QDate::fromString(absence.value("startDate").toString(), "dd-MM-yyyy"));
    smodel.setData(smodel.index(row, 3), QDate::fromString(absence.value("endDate").toString(), "dd-MM-yyyy"));
    smodel.setData(smodel.index(row, 4), absence.value("useRange").toBool());
    smodel.setData(smodel.index(row, 5), absence.value("lateAbsence").toBool());
    smodel.setData(smodel.index(row, 6), absence.value("lateTime").toInt());
    smodel.setData(smodel.index(row, 7), absence.value("earlyAbsence").toBool());
    smodel.setData(smodel.index(row, 8), absence.value("earlyTime").toInt());
    smodel.setData(smodel.index(row, 9), absence.value("isPlanned").toBool());
    smodel.setData(smodel.index(row, 10), absence.value("useCA").toBool());

    return smodel.submitAll();
}
