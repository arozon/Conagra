#include <QApplication>
#include <QQmlApplicationEngine>
#include <QSqlDatabase>
#include <QtSql>
#include <backend.h>
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("localhost");
    db.setDatabaseName("Conagra");
    db.setUserName("root");
    db.setPassword("Arozon21&");
    bool ok = db.open();
    qDebug() << ok;

    QQmlApplicationEngine engine;
    qmlRegisterType<Backend>("artools",1,0,"Backend");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
