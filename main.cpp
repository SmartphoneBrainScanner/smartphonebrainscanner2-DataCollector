#include <QApplication>
#include "qmlapplicationviewer.h"
#include <QtDeclarative>

#include <mycallback.h>

#include <hardware/emotiv/sbs2emotivdatareader.h>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    qDebug() << "catalogPath: "<<Sbs2Common::setDefaultCatalogPath();
    qDebug() << "rootAppPath: "<<Sbs2Common::setDefaultRootAppPath();

    MyCallback* myCallback = new MyCallback();
    Sbs2EmotivDataReader* sbs2DataReader = Sbs2EmotivDataReader::New(myCallback,0);

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/sbs2-DataCollector/main.qml"));
    viewer.showExpanded();

    QObject *rootObject = dynamic_cast<QObject*>(viewer.rootObject());

    QObject::connect(app.data(), SIGNAL(aboutToQuit()), sbs2DataReader, SLOT(aboutToQuit()));
    QObject::connect((QObject*)viewer.engine(), SIGNAL(quit()), app.data(), SLOT(quit()));

    QObject::connect(myCallback, SIGNAL(currentPacketInRecording(QVariant)), rootObject, SLOT(currentPacket(QVariant)));
    QObject::connect(myCallback, SIGNAL(cqValues(QVariant,QVariant)), rootObject, SLOT(cqUpdated(QVariant,QVariant)));
    QObject::connect(rootObject, SIGNAL(startRecording(QString, QString)), myCallback, SLOT(startRecording(QString,QString)));
    QObject::connect(rootObject, SIGNAL(stopRecording()), myCallback, SLOT(stopRecording()));
    QObject::connect(rootObject,  SIGNAL(event(QString)), myCallback, SLOT(insertIntoMetaFile(QString)));

    return app->exec();
}
