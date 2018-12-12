#include <QGuiApplication>
#include <QQuickItem>
#include <QQmlApplicationEngine>
#include <QQmlContext>


#include <mycallback.h>
#include "logcatcher.h"

#include <hardware/emotiv/sbs2emotivdatareader.h>
#include <hardware/filereader/sbs2filedatareader.h>

LogCatcher logcatcher;

void loghandler(QtMsgType type, const QMessageLogContext& ctx, const QString& msg)
{
    Q_UNUSED(type);
    Q_UNUSED(ctx);
    std::cout << qPrintable(msg) << std::endl;
    logcatcher.addLine(msg);
}

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    qInstallMessageHandler(loghandler);
    QGuiApplication app(argc, argv);

    QCommandLineParser parser;
    QCommandLineOption dataFilePath("datafile","File to read instead of device", "filepath");
    parser.addOption(dataFilePath);
    parser.addHelpOption();
    parser.process(app);

    qDebug() << "catalogPath: "<<Sbs2Common::setDefaultCatalogPath();
    qDebug() << "rootAppPath: "<<Sbs2Common::setDefaultRootAppPath();

    MyCallback* myCallback = new MyCallback();
#ifndef Q_OS_ANDROID
    Sbs2DataReader* sbs2DataReader = nullptr;
    if (!parser.isSet(dataFilePath))
    {
        sbs2DataReader = Sbs2EmotivDataReader::New(myCallback,0);
    }
    else
    {
        sbs2DataReader = new Sbs2FileDataReader(myCallback,parser.value(dataFilePath));
    }
#else
    Sbs2DataReader* sbs2DataReader = new Sbs2FileDataReader(myCallback,"assets:/sbs2data_2018_12_01_21_07_22_Test.raw");
#endif

    QString filePath{"qrc:/qml/sbs2-DataCollector/main.qml"};

    QQmlApplicationEngine viewer;
    viewer.rootContext()->setContextProperty("logger",&logcatcher);
    viewer.load(QUrl(filePath));
    if (viewer.rootObjects().isEmpty())
    {
        return 1;
    }

    QObject *rootObject = viewer.rootObjects().first();

    QObject::connect(&app, SIGNAL(aboutToQuit()), sbs2DataReader, SLOT(aboutToQuit()));
    QObject::connect(&viewer, SIGNAL(quit()), &app, SLOT(quit()));

    QObject::connect(myCallback, SIGNAL(currentPacketInRecording(QVariant)), rootObject, SLOT(currentPacket(QVariant)));
    QObject::connect(myCallback, SIGNAL(cqValues(QVariant,QVariant)), rootObject, SLOT(cqUpdated(QVariant,QVariant)));
    QObject::connect(rootObject, SIGNAL(startRecording(QString, QString)), myCallback, SLOT(startRecording(QString,QString)));
    QObject::connect(rootObject, SIGNAL(stopRecording()), myCallback, SLOT(stopRecording()));
    QObject::connect(rootObject,  SIGNAL(event(QString)), myCallback, SLOT(insertIntoMetaFile(QString)));

    return app.exec();
}
