#include "disciplinarymesuremodel.h"

DisciplinaryMesureModel::DisciplinaryMesureModel(int id, int idEmploye, int idQuart, int idDepartement,
                                                 QString category, QString supervisor, QString comment,
                                                 QString action, QString date, QObject *parent) : QObject(parent)
{
    _id = id;
    _idEmploye = idEmploye;
    _idQuart = idQuart;
    _idDepartement = idDepartement;
    _category = category;
    _supervisor = supervisor;
    _action = action;
    _comment = comment;
    _date = date;
}
