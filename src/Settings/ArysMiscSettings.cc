#include "ArysMiscSettings.h"

#include <QQmlEngine>
#include <QtQml>

DECLARE_SETTINGGROUP(ArysMisc, "ArysMisc")
{
    qmlRegisterUncreatableType<ArysMiscSettings>("QGroundControl.SettingsManager", 1, 0, "ArysMiscSettings", "Reference only"); \
}

DECLARE_SETTINGSFACT(ArysMiscSettings, userPassword)
DECLARE_SETTINGSFACT(ArysMiscSettings, masterPasssword)
DECLARE_SETTINGSFACT(ArysMiscSettings, pswdNeeded)