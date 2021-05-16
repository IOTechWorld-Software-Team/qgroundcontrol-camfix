import QtQuick              2.3
import QtQuick.Controls     2.4
import QtQuick.Layouts      1.2

import QGroundControl                   1.0
import QGroundControl.Controls          1.0
import QGroundControl.ScreenTools       1.0
import QGroundControl.SettingsManager   1.0
import QGroundControl.Palette           1.0


Item {
    id: root

    signal passwordCorrect
    signal closePopup

    Component.onCompleted: {
        pswdPopup.open()
    }

    Popup {
        id:                 pswdPopup
        width:              ScreenTools.defaultFontPixelWidth * 40
        height:             ScreenTools.defaultFontPixelWidth * 25
        padding:            ScreenTools.defaultFontPixelHeight * 0.25
        modal:              true
        focus:              true
        closePolicy:        Popup.CloseOnEscape | Popup.CloseOnPressOutside

        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)

        background: Rectangle {
            anchors.fill:   parent
            color:          qgcPal.window
            // radius:         ScreenTools.defaultFontPixelHeight * 0.5
        }

        contentItem: Item{
            id: rootPopupItem

            function passwordOk() {
                root.passwordCorrect()
                pswdPopup.close()
                // set advanced mode, second argument is for showing a warning, only used when called here
                QGroundControl.arysPasswordManager.setAdvanced(true, true)

            }

            function passwordNotOk() {
                pswdTextField.text = ""
                pswdTextField.placeholderText = "Incorrect password"
                wrongPasswordLabel.visible = true
            }

            ColumnLayout {
                id:                 pwsdMessageColumn
                anchors.centerIn:   parent
                spacing:            ScreenTools.defaultFontPixelHeight * 0.25

                QGCLabel {
                    Layout.alignment:       Qt.AlignHCenter
                    Layout.maximumWidth:    rootPopupItem.width * 0.9
                    text:                   qsTr("Enter password to acces settings menu. Otherwise click outside of this window to close.")
                    wrapMode:               Text.WordWrap
                }
                QGCTextField {
                    id:                     pswdTextField
                    Layout.alignment:       Qt.AlignHCenter
                    Layout.preferredWidth:  ScreenTools.defaultFontPixelWidth * 20
                    echoMode:               TextInput.Password

                    onAccepted: {
                        if (QGroundControl.arysPasswordManager.checkCorrectPassword(pswdTextField.text)) {
                            rootPopupItem.passwordOk()
                        } else {
                            rootPopupItem.passwordNotOk()
                        }
                    }
                }
                QGCButton {
                    id:                     enterButton
                    Layout.alignment:       Qt.AlignHCenter
                    Layout.preferredWidth:  ScreenTools.defaultFontPixelWidth * 15
                    text:                   qsTr("Enter")
                    // backRadius:             ScreenTools.defaultFontPixelHeight * 0.25

                    onClicked: {
                        if (QGroundControl.arysPasswordManager.checkCorrectPassword(pswdTextField.text)) {
                            rootPopupItem.passwordOk()
                        } else {
                            rootPopupItem.passwordNotOk()
                        }
                    }
                }

                QGCLabel {
                    id:                     wrongPasswordLabel
                    Layout.alignment:       Qt.AlignHCenter
                    Layout.maximumWidth:    rootPopupItem.width * 0.8
                    text:                   qsTr("Wrong Password, please try again")
                    wrapMode:               Text.WordWrap
                    color:                  qgcPal.colorRed
                    visible:                false
                }
            }
        }

        onClosed: {
            root.closePopup()
            wrongPasswordLabel.visible = false
            pswdTextField.text = ""
            pswdTextField.placeholderText = ""
        }
    }
}