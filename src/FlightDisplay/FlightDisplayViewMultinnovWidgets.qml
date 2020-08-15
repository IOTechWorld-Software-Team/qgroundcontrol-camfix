import QtQuick                  2.3
import QtQuick.Controls         1.2
import QtQuick.Extras           1.4
import QtQuick.Controls.Styles  1.4

import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.Palette       1.0
import QGroundControl.ScreenTools   1.0


Item {
    id: root 
    anchors.fill:   parent

    property real   _margins:               ScreenTools.defaultFontPixelWidth / 2

    Rectangle {
        anchors.margins:        _margins
        anchors.verticalCenter: root.verticalCenter
        anchors.right:          root.right
        height:                 root.height * 0.4
        width:                  ScreenTools.defaultFontPixelHeight * 3
        color:                  qgcPal.window
        radius:                 ScreenTools.defaultFontPixelHeight
        border.color:           qgcPal.text
        border.width:           1

        Column {
            id:                 ledColumn
            anchors.margins:    ScreenTools.defaultFontPixelHeight
            anchors.top:        parent.top
            anchors.left:       parent.left
            anchors.right:      parent.right

            QGCLabel {
                id:                     ledLabel
                anchors.left:           parent.left
                anchors.right:          parent.right
                horizontalAlignment:    Text.AlignHCenter
                text:                   qsTr("LEDS")
            }

            QGCLabel {
                anchors.left:           parent.left
                anchors.right:          parent.right
                horizontalAlignment:    Text.AlignHCenter
                font.pointSize:         ScreenTools.mediumFontPointSize
                text:                   qsTr("+")
            }
        }


        QGCSlider {
            id:                         ledSlider
            anchors.top:                ledColumn.bottom
            anchors.bottom:             minusLabel.top
            anchors.horizontalCenter:   parent.horizontalCenter

            orientation:    Qt.Vertical
            minimumValue:   0
            maximumValue:   2000
            rotation:       180

            // We want slide up to be positive values
            transform: Rotation {
                origin.x:   ledSlider.width / 2
                origin.y:   ledSlider.height / 2
                angle:      180
            }
        }

            /* Nov-Dev: todo include the PWM functionality

            We will use the value of ledSlider.value as a direct paramenter to pass over the RCoverride

        */

        QGCLabel {
            id: minusLabel

            anchors.left:       parent.left
            anchors.right:      parent.right
            anchors.bottom:     parent.bottom
            anchors.margins:    _margins

            wrapMode:               Text.WordWrap
            horizontalAlignment:    Text.AlignHCenter
            font.pointSize:         ScreenTools.mediumFontPointSize
            text:                   qsTr("-") 
        }        
    }

    QGCLabel {
            id: cameraAngleLabel

            anchors.margins:    _margins
            anchors.top:        root.top
            anchors.left:       root.left
            anchors.topMargin:  ScreenTools.toolbarHeight + _margins

            font.pointSize: ScreenTools.largeFontPointSize
            text:           qsTr("CAMERA") 
            color:          qgcPal.window
            font.bold:      true
        }        

    Item {
        id: circularGaugeContainer

        anchors.margins:    ScreenTools.defaultFontPixelHeight
        anchors.top:        cameraAngleLabel.bottom
        anchors.left:       root.left
        anchors.topMargin:  _margins

        height:     parent.height * 0.3
        width:      angleGauge.width * 0.6
        //radius:
        //color:      qgcPal.window
        //opacity:    0.3

        CircularGauge {
            id:     angleGauge

            readonly property int _pwmMin:      1000
            readonly property int _pwmMax:      2000
            readonly property int _pwmRange:    _pwmMax - _pwmMin

            anchors.horizontalCenter:   parent.left
            anchors.top:                parent.top
            anchors.bottom:             parent.bottom

            minimumValue:   -90
            maximumValue:   90

            value:  pwmToDegrees(1500)  //Nov-Dev: this needs to change accordingly to selected channel.
                                        //Instead of fixed 1500 inside the function should go the RCChannel that corresponds to the angle of the camera

            function pwmToDegrees(pwm) {
                if ((pwm - _pwmRange) > 500) {
                    return ((pwm - _pwmRange - 500) / 5.55)
                }
                if ((pwm - _pwmRange) < 500) {
                    return ( - (pwm - _pwmRange) / 5.55)
                }
                return 0
            }            

            style: CircularGaugeStyle {

                maximumValueAngle:  0
                minimumValueAngle:  180

                foreground: null

                needle: Rectangle {
                    y:              outerRadius * 0.15
                    implicitWidth:  outerRadius * 0.04
                    implicitHeight: outerRadius * 0.9
                    antialiasing:   true
                    color:          qgcPal.colorRed
                }

                tickmarkStepSize:   45

                tickmarkLabel:  Text {
                    font.pixelSize: Math.max(ScreenTools.largeFontPointSize, outerRadius * 0.1)
                    text:           styleData.value
                    color:          qgcPal.window
                    antialiasing:   true
                    font.bold:      true
                }

                tickmark: Rectangle {
                    implicitWidth:  outerRadius * 0.04
                    implicitHeight: outerRadius * 0.1
                    antialiasing:   true
                    color:          qgcPal.window
                }

                minorTickmark: Rectangle {
                    implicitWidth:  outerRadius * 0.03
                    implicitHeight: outerRadius * 0.05
                    antialiasing:   true
                    color:          qgcPal.window
                }
            }
        }
    }
}