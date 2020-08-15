import QtQuick                          2.11
import QtQuick.Controls                 2.4
import QtQuick.Layouts                  1.2

import QGroundControl                       1.0
import QGroundControl.Controls              1.0
import QGroundControl.MultiVehicleManager   1.0
import QGroundControl.ScreenTools           1.0
import QGroundControl.Palette               1.0

Item {
    id: toolbarRoot

    height: _fillerRectangle.height

    property var  _activeVehicle:       QGroundControl.multiVehicleManager.activeVehicle
    property bool _communicationLost:   _activeVehicle ? _activeVehicle.connectionLost : false
    property bool _armed:             _activeVehicle ? _activeVehicle.armed : false

    signal armVehicle
    signal disarmVehicle

    ButtonGroup {
        id: modeGroupButton
    }

    Rectangle {

        id: _fillerRectangle

        anchors.fill: parent
        height: rowLayoutButtons.height + ScreenTools.defaultFontPixelHeight 

        color:      qgcPal.window
        opacity:    0.5

    }

    RowLayout {

        id: rowLayoutButtons

        anchors.centerIn:   parent

        spacing:    ScreenTools.defaultFontPixelHeight * 2
        

        height:     altHoldButton.height

        QGCButtonNov {
            id:                     altHoldButton
            ButtonGroup.group:      modeGroupButton
            text:                   qsTr("Altitude Hold")

            onClicked:  {
                if (_activeVehicle) {
                    _activeVehicle.flightMode = "Altitude Hold"
                }
            }
            checked:    _activeVehicle && _activeVehicle.flightMode === "Altitude Hold" ? true : false
        }

        QGCButtonNov {
            id:                     loiterButton
            ButtonGroup.group:      modeGroupButton
            text:                   qsTr("Loiter")
            
            onClicked:  {
                if (_activeVehicle) {
                    _activeVehicle.flightMode = "Loiter"
                }
            }
            checked:    _activeVehicle && _activeVehicle.flightMode === "Loiter" ? true : false
        }

        QGCButtonNov {
            id:                     wallButton
            ButtonGroup.group:      modeGroupButton
            text:                   qsTr("Wall")
            //onClicked:              _activeVehicle.
        }

        QGCButtonNov {
            id:                     roofButton
            ButtonGroup.group:      modeGroupButton
            text:                   qsTr("Roof")
            //onClicked:              _activeVehicle.
        }

        QGCButtonNov {
            id:             armButton
            text:           _activeVehicle ? (_armed ? qsTr("DISARM") : qsTr("ARM")) : qsTr("ARM")
            onClicked:      _armed ? toolBar.disarmVehicle() : toolBar.armVehicle()
            armingButton:   true
        }
    }
}