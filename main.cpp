#include <QGuiApplication>
#include <QQuickView>
#include <QQuickItem>
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
    viewer.load(QUrl::fromLocalFile(filePath));

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
