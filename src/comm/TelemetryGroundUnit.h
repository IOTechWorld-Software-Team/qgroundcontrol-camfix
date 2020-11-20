#pragma once

#include "QGCToolbox.h"
#include "MAVLinkProtocol.h"

class QGCApplication;

class TelemetryGroundUnit: public QGCTool
{
    Q_OBJECT

public:

    TelemetryGroundUnit(QGCApplication* app, QGCToolbox* toolbox);
    ~TelemetryGroundUnit();

    void setToolbox(QGCToolbox *toolbox);

private slots:

    void _radioStatusInfo(mavlink_radio_status_t radiostatus);

    friend class MAVLinkProtocol;
};