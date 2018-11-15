#ifndef DISCIPLINARYMESUREMODEL_H
#define DISCIPLINARYMESUREMODEL_H

#include <QObject>

class DisciplinaryMesureModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(int idEmploye READ idEmploye WRITE setId NOTIFY idEmployeChanged)
    Q_PROPERTY(int idQuart READ idQuart WRITE setIdQuart NOTIFY idQuartChanged)
    Q_PROPERTY(int idDepartement READ idDepartement WRITE setIdDepartement NOTIFY idDepartementChanged)
    Q_PROPERTY(QString category READ category WRITE setCategory NOTIFY categoryChanged)
    Q_PROPERTY(QString supervisor READ supervisor WRITE setSupervisor NOTIFY supervisorChanged)
    Q_PROPERTY(QString comment READ comment WRITE setComment NOTIFY commentChanged)
    Q_PROPERTY(QString action READ action WRITE setAction NOTIFY actionChanged)
    Q_PROPERTY(QString date READ date WRITE setDate NOTIFY dateChanged)
public:
    explicit DisciplinaryMesureModel(int id, int idEmploye, int idQuart, int idDepartement,
                                     QString category, QString supervisor, QString comment,
                                     QString action, QString date, QObject *parent = nullptr);


    int id() {
        return _id;
    }
    int idEmploye() {
        return _idEmploye;
    }
    int idQuart() {
        return _idQuart;
    }
    int idDepartement() {
        return _idDepartement;
    }
    QString category() {
        return _category;
    }
    QString supervisor() {
        return _supervisor;
    }
    QString comment() {
        return _comment;
    }
    QString action() {
        return _action;
    }
    QString date() {
        return _date;
    }

    void setId(int value) {
        _id = value;
        emit idChanged();
    }
    void setIdEmploye(int value) {
        _idEmploye = value;
        emit idEmployeChanged();
    }
    void setIdQuart(int value) {
        _idQuart = value;
        emit idQuartChanged();
    }
    void setIdDepartement(int value) {
        _idDepartement = value;
        emit idDepartementChanged();
    }
    void setCategory(QString value) {
        _category = value;
        emit categoryChanged();
    }
    void setSupervisor(QString value) {
        _supervisor = value;
        emit supervisorChanged();
    }
    void setComment(QString value) {
        _comment = value;
        emit commentChanged();
    }
    void setAction(QString value) {
        _action = value;
        emit actionChanged();
    }
    void setDate(QString value) {
        _date = value;
        emit dateChanged();
    }

private:
    int _id;
    int _idEmploye;
    int _idQuart;
    int _idDepartement;
    QString _category;
    QString _supervisor;
    QString _comment;
    QString _action;
    QString _date;

signals:
    void idChanged();
    void idEmployeChanged();
    void idQuartChanged();
    void idDepartementChanged();
    void categoryChanged();
    void supervisorChanged();
    void commentChanged();
    void actionChanged();
    void dateChanged();

public slots:
};

#endif // DISCIPLINARYMESUREMODEL_H
