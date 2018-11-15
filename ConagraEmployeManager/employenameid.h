#ifndef EMPLOYENAMEID_H
#define EMPLOYENAMEID_H

#include <QObject>


class EmployeNameID : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
public:
    explicit EmployeNameID(QString nam, int i, QObject *parent = nullptr);

    QString name() {
        return _name;
    }

    int id() {
        return _id;
    }

    void setName(QString value){
        _name = value;
        emit nameChanged();
    }

    void setId(int value) {
        _id = value;
        emit idChanged();
    }

private:
    QString _name;
    int _id;

signals:
    void nameChanged();
    void idChanged();

public slots:
};

#endif // EMPLOYENAMEID_H
