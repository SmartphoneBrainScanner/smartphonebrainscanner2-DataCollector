QT += quick

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

SOURCES += main.cpp \
    mycallback.cpp \
    logcatcher.cpp

include(../smartphonebrainscanner2-core/src/sbs2.pri)

target.path = /bin/
INSTALLS += target

win32:RC_ICONS += datacollector.ico

HEADERS += \
    mycallback.h \
    logcatcher.h

RESOURCES += \
    resources.qrc
