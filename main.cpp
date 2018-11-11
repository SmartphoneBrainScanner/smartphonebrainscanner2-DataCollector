#include <QGuiApplication>
#include <QQuickItem>
#include <QQmlApplicationEngine>
#include <QQmlContext>


#include <mycallback.h>
#include "logcatcher.h"

#include <hardware/emotiv/sbs2emotivdatareader.h>

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

    qDebug() << "catalogPath: "<<Sbs2Common::setDefaultCatalogPath();
    qDebug() << "rootAppPath: "<<Sbs2Common::setDefaultRootAppPath();

    MyCallback* myCallback = new MyCallback();
    Sbs2EmotivDataReader* sbs2DataReader = Sbs2EmotivDataReader::New(myCallback,0);

    QStringList candidatePaths{"/bin/", QCoreApplication::applicationDirPath()};
    QString filePath{"qml/sbs2-DataCollector/main.qml"};
    if (!QFile::exists(filePath))
    {
        for(const auto& path : qAsConst(candidatePaths))
        {
            QString testPath = path + "/" + filePath;
            if (QFile::exists(testPath))
            {
                filePath = testPath;
                break;
            }
        }
    }

    QQmlApplicationEngine viewer;
    viewer.rootContext()->setContextProperty("logger",&logcatcher);
    viewer.load(QUrl::fromLocalFile(filePath));
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
