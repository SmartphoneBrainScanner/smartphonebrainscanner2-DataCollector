QT += quick

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

SOURCES += main.cpp \
    mycallback.cpp

include(../smartphonebrainscanner2-core/src/sbs2.pri)


HEADERS += \
    mycallback.h

RESOURCES += \
    resources.qrc
