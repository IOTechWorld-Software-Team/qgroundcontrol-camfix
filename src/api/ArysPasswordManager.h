#pragma once

#include "QGCToolbox.h"
#include "QmlObjectListModel.h"

class ArysPasswordManager : public QGCTool {
    Q_OBJECT

public:
    ArysPasswordManager(QGCApplication* app, QGCToolbox* toolbox);

    void setToolbox(QGCToolbox* toolbox) final;

    Q_PROPERTY(QString  usrPswd         READ usrPswd        NOTIFY usrPswdChanged)
    Q_PROPERTY(QString  masterPswd      READ masterPswd     CONSTANT)
    Q_PROPERTY(bool     advancedMode    READ advancedMode   NOTIFY advancedModeChanged)

    Q_INVOKABLE void setUserPassword(QString newPswd);
    Q_INVOKABLE void setAdvanced(bool advancedMode, bool showWarning = false);
    Q_INVOKABLE bool checkCorrectPassword(QString pswd);

    QString usrPswd         (void) const { return _usrPswd; }
    QString masterPswd      (void) const { return _masterPswd; }
    bool    advancedMode    (void) const { return _advancedMode;}

signals:
    void usrPswdChanged         (QString usrPswd);
    void advancedModeChanged    (bool advancedMode);

private:
    QString     _usrPswd;
    QString     _masterPswd;
    bool        _advancedMode = false;

    void init(void);
};