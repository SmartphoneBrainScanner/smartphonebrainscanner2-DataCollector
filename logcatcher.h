#ifndef LOGCATCHER_H
#define LOGCATCHER_H

#include <QObject>
#include <QList>
#include <QVariant>

class LogCatcher : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariant lines READ lines NOTIFY changed)
public:
    explicit LogCatcher(QObject *parent = nullptr);
    void addLine(const QString& line);
    QVariant lines() const;
Q_SIGNALS:
    void changed();
private:
    QList<QString> m_logs;
};

#endif // LOGCATCHER_H
