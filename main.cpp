#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "calcul.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    Calcul myCalcul;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("myCalcul",&myCalcul);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
