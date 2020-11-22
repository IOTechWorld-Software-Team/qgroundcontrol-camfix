#pragma once

#include "QGCToolbox.h"
#include "MAVLinkProtocol.h"

class QGCApplication;

class TelemetryGroundUnit: public QGCTool
{
    Q_OBJECT

public:
    Q_PROPERTY(int sbdQuality   READ sbdQuality   NOTIFY onSbdQualityChanged);
    Q_PROPERTY(int smsQuality1  READ smsQuality1  NOTIFY onSmsQuality1Changed);
    Q_PROPERTY(int smsQuality2  READ smsQuality2  NOTIFY onSmsQuality2Changed);
    Q_PROPERTY(int smsQuality3  READ smsQuality3  NOTIFY onSmsQuality3Changed);
    Q_PROPERTY(bool currentlyThrottled   READ currentlyThrottled   NOTIFY onCurrentlyThrottledChanged);
    Q_PROPERTY(bool ocurredThrottled     READ ocurredThrottled     NOTIFY onOcurredThrottledChanged);
    Q_PROPERTY(bool lowVolt              READ lowVolt              NOTIFY onLowVoltChanged);
    Q_PROPERTY(bool ocurredLowVolt       READ ocurredLowVolt       NOTIFY onOcurredLowVoltChanged);

    int sbdQuality(void)           { return _sbd_quality; }
    int smsQuality1(void)          { return _sms_quality1; }
    int smsQuality2(void)          { return _sms_quality2; }
    int smsQuality3(void)          { return _sms_quality3; }
    bool currentlyThrottled(void)  { return _currentlyThrottled; }
    bool ocurredThrottled(void)    { return _ocurredThrottled; }
    bool lowVolt(void)             { return _lowVolt; }
    bool ocurredLowVolt(void)      { return _ocurredLowVolt; }    

    TelemetryGroundUnit(QGCApplication* app, QGCToolbox* toolbox);
    ~TelemetryGroundUnit();

    void setToolbox(QGCToolbox *toolbox);

private slots:

    void _radioStatusInfo(mavlink_radio_status_t radiostatus);

    friend class MAVLinkProtocol;

signals:

    void onSbdQualityChanged(void);
    void onSmsQuality1Changed(void);
    void onSmsQuality2Changed(void);
    void onSmsQuality3Changed(void);
    void onCurrentlyThrottledChanged(void);
    void onOcurredThrottledChanged(void);
    void onLowVoltChanged(void);
    void onOcurredLowVoltChanged(void);

private:

    // raw groundpi radio status message
    int _sbd_quality = 0;
    int _sms_quality1 = 0;
    int _sms_quality2 = 0;
    int _sms_quality3 = 0;
    uint8_t _status_bitmask = 255; // uninitialized value
    uint8_t _link_bitmask = 0; // depends only on each aircraft

    bool _currentlyThrottled = false;
    bool _ocurredThrottled = false;
    bool _lowVolt = false;
    bool _ocurredLowVolt = false;
};