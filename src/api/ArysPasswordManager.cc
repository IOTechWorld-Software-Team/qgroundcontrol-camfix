#include "ArysPasswordManager.h"
#include "QGCLoggingCategory.h"
#include "QGCApplication.h"
#include "SettingsManager.h"

#include <QDebug>
#include <QString>

ArysPasswordManager::ArysPasswordManager(QGCApplication* app, QGCToolbox* toolbox)
    :  QGCTool  (app, toolbox) {}

void ArysPasswordManager::setToolbox(QGCToolbox* toolbox)
{
    QGCTool::setToolbox(toolbox);
    init();
}

//We need this function to initialize the value at startup, but
//after the toolbox have been generated
void ArysPasswordManager::init(void)
{
    _masterPswd = _toolbox->settingsManager()->arysMiscSettings()->masterPasssword()->rawValueString();
    _usrPswd = _toolbox->settingsManager()->arysMiscSettings()->userPassword()->rawValueString();
    _advancedMode = !_toolbox->settingsManager()->arysMiscSettings()->pswdNeeded()->rawValue().toBool();
}

void ArysPasswordManager::setUserPassword(QString newPswd)
{
    if (newPswd != _usrPswd) {
        _usrPswd = newPswd;
        _toolbox->settingsManager()->arysMiscSettings()->userPassword()->setRawValue(newPswd);
        emit usrPswdChanged(newPswd);
    }
}

//Changes the status of the advanced mode
void ArysPasswordManager::setAdvanced(bool advancedMode, bool showWarning)
{
    if (advancedMode != _advancedMode) {
        _advancedMode = advancedMode;
        emit advancedModeChanged(advancedMode);
    }

    if (_advancedMode && showWarning) {
        qgcApp()->showAppMessage(tr("GCS is now in advanced mode. This will not persist reboots unless user mode is unchecked in Vision Aerial settings"));
    }
}

bool ArysPasswordManager::checkCorrectPassword(QString pswd)
{
    if (pswd == _usrPswd || pswd == _masterPswd) {
        return true;
    }
    return false;
}