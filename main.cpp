#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <mycallback.h>

#include <hardware/emotiv/sbs2emotivdatareader.h>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qDebug() << "catalogPath: "<<Sbs2Common::setDefaultCatalogPath();
    qDebug() << "rootAppPath: "<<Sbs2Common::setDefaultRootAppPath();

    MyCallback* myCallback = new MyCallback();
    Sbs2EmotivDataReader* sbs2DataReader = Sbs2EmotivDataReader::New(myCallback,0);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    // Get access to the rectangle
    QObject *rootObject = engine.rootObjects().first();
    QObject *rect = rootObject->findChild<QObject*>("rect");

    QObject::connect(&app, SIGNAL(aboutToQuit()), sbs2DataReader, SLOT(aboutToQuit()));
    QObject::connect(&engine, SIGNAL(quit()), &app, SLOT(quit()));

    QObject::connect(myCallback, SIGNAL(currentPacketInRecording(QVariant)), rect, SLOT(currentPacket(QVariant)));
    QObject::connect(myCallback, SIGNAL(cqValues(QVariant,QVariant)), rect, SLOT(cqUpdated(QVariant,QVariant)));
    QObject::connect(rect, SIGNAL(startRecording(QString, QString)), myCallback, SLOT(startRecording(QString,QString)));
    QObject::connect(rect, SIGNAL(stopRecording()), myCallback, SLOT(stopRecording()));
    QObject::connect(rect,  SIGNAL(event(QString)), myCallback, SLOT(insertIntoMetaFile(QString)));

    return app.exec();
}
