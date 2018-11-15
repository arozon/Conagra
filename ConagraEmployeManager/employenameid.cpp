#include "employenameid.h"


EmployeNameID::EmployeNameID(QString name, int id, QObject *parent) : QObject (parent)
{
    _name = name;
    _id = id;
}
