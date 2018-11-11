#include "logcatcher.h"

LogCatcher::LogCatcher(QObject *parent) : QObject(parent)
{
    
}

void LogCatcher::addLine(const QString &line)
{
    m_logs.append(line);
    emit changed();
}

QVariant LogCatcher::lines() const {
    return m_logs;
}
