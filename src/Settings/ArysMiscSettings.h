#pragma once

#include "SettingsGroup.h"

class ArysMiscSettings : public SettingsGroup
{
    Q_OBJECT
public:
    ArysMiscSettings(QObject* parent = nullptr);
    DEFINE_SETTING_NAME_GROUP()

    DEFINE_SETTINGFACT(userPassword)
    DEFINE_SETTINGFACT(masterPasssword)
    DEFINE_SETTINGFACT(pswdNeeded)
};