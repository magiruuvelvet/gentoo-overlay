CONFIG += qt plugin
QT += core widgets

QMAKE_CXXFLAGS += -shared -L/usr/lib64/qtcreator/plugins -lTextEditor
QMAKE_LFLAGS += -shared -L/usr/lib64/qtcreator/plugins -lTextEditor

QMAKE_RPATHDIR += $ORIGIN

INCLUDEPATH += \
    /usr/src/dev-qt/qt-creator/src/plugins \
    /usr/src/dev-qt/qt-creator/src/libs \
    /usr/src/dev-qt/qt-creator/src/libs/3rdparty \
    /usr/src/dev-qt/qt-creator/src/libs/3rdparty/syntax-highlighting/src/lib \
    /usr/src/dev-qt/qt-creator/src/libs/3rdparty/syntax-highlighting/autogenerated/src/lib

DISTFILES += json_in
QMAKE_SUBSTITUTES += json_in
PLUGINJSON = json_out

TARGET = target_name
