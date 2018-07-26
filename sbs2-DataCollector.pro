QT += quick

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

SOURCES += main.cpp \
    mycallback.cpp

include(../smartphonebrainscanner2-core/src/sbs2.pri)

target.path = /bin/
qml.path = /bin/qml/sbs2-DataCollector/
qml.files = qml/sbs2-DataCollector/*.qml
INSTALLS += target qml

win32:RC_ICONS += datacollector.ico

HEADERS += \
    mycallback.h

RESOURCES += \
    resources.qrc
