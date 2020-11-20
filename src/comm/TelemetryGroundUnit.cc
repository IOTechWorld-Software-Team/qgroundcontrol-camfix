#include "TelemetryGroundUnit.h"
#include "QGCApplication.h"

#include <QDebug>

TelemetryGroundUnit::TelemetryGroundUnit(QGCApplication* app, QGCToolbox* toolbox)
    : QGCTool(app, toolbox) {}

TelemetryGroundUnit::~TelemetryGroundUnit()
{

}

void TelemetryGroundUnit::setToolbox(QGCToolbox *toolbox)
{
    QGCTool::setToolbox(toolbox);
}

void TelemetryGroundUnit::_radioStatusInfo(mavlink_radio_status_t radiostatus) {
    qDebug() << "radio status received!";
}