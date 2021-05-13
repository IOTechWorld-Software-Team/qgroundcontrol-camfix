import QtQuick                  2.3
import QtQuick.Controls         2.4
import QtQuick.Controls.Styles  1.4
import QtQuick.Dialogs          1.2
import QtQuick.Layouts          1.2

import QGroundControl                       1.0
import QGroundControl.FactSystem            1.0
import QGroundControl.FactControls          1.0
import QGroundControl.Controls              1.0
import QGroundControl.ScreenTools           1.0
import QGroundControl.MultiVehicleManager   1.0
import QGroundControl.Palette               1.0
import QGroundControl.Controllers           1.0
import QGroundControl.SettingsManager       1.0

Rectangle {
    id:                 _root
    color:              qgcPal.window
    anchors.fill:       parent
    anchors.margins:    ScreenTools.defaultFontPixelWidth

    property real _margins:                     ScreenTools.defaultFontPixelWidth
    property real _comboFieldWidth:             ScreenTools.defaultFontPixelWidth * 20
    property real _valueFieldWidth:             ScreenTools.defaultFontPixelWidth * 10

    QGCFlickable {
        id:                 mainflikable
        clip:               true
        height:             parent.height * 0.9
        anchors.fill:       parent
        contentHeight:      outerItem.height
        contentWidth:       outerItem.width

        Item {
            id:     outerItem
            width:  Math.max(_root.width, settingsItem.width)
            height: settingsItem.height

            ColumnLayout {
                id:                         settingsItem
                anchors.horizontalCenter:   parent.horizontalCenter

                QGCLabel {
                    id:         customSettingsLabel
                    text:       qsTr("Vision Aerial Settings")
                    visible:    QGroundControl.settingsManager.arysMiscSettings.visible
                    Layout.alignment:   Qt.AlignHCenter
                }

                Rectangle {
                    id: settingsRectangle
                    Layout.preferredHeight: customSettingsGrid.height + (_margins * 2)
                    Layout.preferredWidth:  customSettingsGrid.width + (_margins * 2)
                    color:                  qgcPal.windowShade
                    visible:                true
                    Layout.fillWidth:       true

                    GridLayout {
                        id:                         customSettingsGrid
                        anchors.topMargin:          _margins
                        anchors.top:                parent.top
                        Layout.fillWidth:           false
                        anchors.horizontalCenter:   parent.horizontalCenter
                        columns:                    2
                        rowSpacing:                 _margins * 3

                        QGCLabel {
                            id:         enterNewPswdField
                            text:       qsTr("Set new password::")
                            visible:    QGroundControl.settingsManager.arysMiscSettings.userPassword.visible
                        }
                        QGCTextField {
                            id:                     enterNewPswdTextField
                            Layout.preferredWidth:  _valueFieldWidth * 1.5
                            placeholderText:        "New password"
                            echoMode:               TextInput.Password
                        }
                        QGCLabel {
                            id:         confirmNewPswdField
                            text:       qsTr("Confirm new password:")
                            visible:    QGroundControl.settingsManager.arysMiscSettings.userPassword.visible
                        }
                        QGCTextField {
                            id:                     confirmNewPswdTextField
                            Layout.preferredWidth:  _valueFieldWidth * 1.5
                            placeholderText:        "Confirm password"
                            echoMode:               TextInput.Password
                            onAccepted: {
                                if (text == enterNewPswdTextField.text) {
                                    QGroundControl.arysPasswordManager.setUserPassword(text)
                                } else {
                                    passwordWarningLabel.visible = true
                                }
                                text = ""
                                enterNewPswdTextField.text = ""
                            }
                        }
                        QGCLabel {
                            id:         userPasswordNeeded
                            text:       qsTr("Set User mode")
                            visible:    QGroundControl.settingsManager.arysMiscSettings.pswdNeeded.visible
                        }
                        FactCheckBox {
                            text:       qsTr("Activate")
                            visible:    QGroundControl.settingsManager.arysMiscSettings.pswdNeeded.visible
                            fact:       QGroundControl.settingsManager.arysMiscSettings.pswdNeeded
                            // This is needed so password manager is updated real time
                            onClicked:  { QGroundControl.arysPasswordManager.setAdvanced(!fact.rawValue) }
                        }
                    }
                }

                QGCLabel {
                            id: passwordWarningLabel
                            Layout.preferredWidth:  settingsRectangle.width
                            text:       qsTr("Confirmation password does not match new set password.")
                            color:      qgcPal.colorRed
                            wrapMode:   Text.WordWrap
                            visible:    false
                        }
            }
        }
    }
}