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

    _sbd_quality = radiostatus.rxerrors;
    _sms_quality1 = radiostatus.rssi;
    _sms_quality2 = radiostatus.remrssi;
    _sms_quality3 = radiostatus.txbuf;
    _status_bitmask = radiostatus.noise;
    _link_bitmask = radiostatus.remnoise; // always 0, depends on the aircraft

    if ( _status_bitmask & (1 << 0) ) // Low voltage happening
        _lowVolt = true;
    else
        _lowVolt = false;

    if ( _status_bitmask & (1 << 2) ) // throttling happening
        _currentlyThrottled = true;
    else
        _currentlyThrottled = false;
    
    if ( _status_bitmask & (1 << 4) ) // low voltage ocurred
        _ocurredLowVolt = true;
    else
        _ocurredLowVolt = false;
    
    if ( _status_bitmask & (1 << 6) ) // throttling ocurred
        _ocurredThrottled = true;
    else
        _ocurredThrottled = false;

    emit onSbdQualityChanged();
    emit onSmsQuality1Changed();
    emit onSmsQuality2Changed();
    emit onSmsQuality3Changed();
    emit onCurrentlyThrottledChanged();
    emit onOcurredThrottledChanged();
    emit onLowVoltChanged();
    emit onOcurredLowVoltChanged();
}