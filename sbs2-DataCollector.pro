# Add more folders to ship with the application, here
folder_01.source = qml/sbs2-DataCollector
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

TEMPLATE = app

QT += qml quick

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    mycallback.cpp

include(../smartphonebrainscanner2-core/src/sbs2.pri)


HEADERS += \
    mycallback.h

RESOURCES += \
    qml.qrc
