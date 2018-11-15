#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QtSql>
#include <QDate>

class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr);
    explicit Backend(QSqlDatabase database, QObject *parent = nullptr);
    Q_INVOKABLE bool addEmploye(const QJsonObject &employe);
    Q_INVOKABLE QVariant getEmployeNamesAndID();
    Q_INVOKABLE QJsonObject getEmployeByID(const int &id);
    Q_INVOKABLE bool updateEmploye(const QJsonObject &employe, const int &id);
    Q_INVOKABLE bool addDisciplinaryMesure(const QJsonObject &mesure);
    Q_INVOKABLE QVariant getDisciplinaryMesures(const int &id);
    Q_INVOKABLE bool updateDisciplinaryMesure(const QJsonObject &mesure, const int &id);
    Q_INVOKABLE bool addAbsence(const QJsonObject &absence);




private:
    QSqlDatabase db;


signals:

public slots:
};

#endif // BACKEND_H
