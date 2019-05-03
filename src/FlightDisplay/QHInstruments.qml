import QtQuick                  2.3
import QtQuick.Controls         1.2
import QtQuick.Controls.Styles  1.4
import QtQuick.Dialogs          1.2
import QtLocation               5.3
import QtPositioning            5.3
import QtQuick.Layouts          1.2
import QtQuick.Window           2.2
import QtQml.Models             2.1

import QGroundControl               1.0
import QGroundControl.Airspace      1.0
import QGroundControl.Controllers   1.0
import QGroundControl.Controls      1.0
import QGroundControl.FactSystem    1.0
import QGroundControl.FlightDisplay 1.0
import QGroundControl.FlightMap     1.0
import QGroundControl.Palette       1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Vehicle       1.0

// onUserPannedChanged: {
//     if (userPanned) {
//         console.log("user panned")
//         userPanned = false
//         _disableVehicleTracking = true
//         panRecenterTimer.restart()
//     }
// }


Item {

    id: qhroot
    height: 200
    width: 450

    Rectangle {

        id: qhrectangle
        anchors.fill: parent
        color: "black"
        radius: 20

        GridLayout {
            id:                 qhinstrumentsgrid
            anchors.margins:    ScreenTools.defaultFontPixelHeight
            columnSpacing:      ScreenTools.defaultFontPixelWidth
            columns:            2
            anchors.horizontalCenter: parent.horizontalCenter

            QGCLabel { text: qsTr("Voltage:") }
            QGCLabel { text: (_activeVehicle && _activeVehicle.battery.voltage.value != -1) ? (_activeVehicle.battery.voltage.valueString + " " + _activeVehicle.battery.voltage.units) : "N/A" }
            QGCLabel { text: qsTr("Current generator:") }
            QGCLabel { text: (_activeVehicle && _activeVehicle.battery.current_generator.value != -1) ? (_activeVehicle.battery.current_generator.valueString + " " + _activeVehicle.battery.current_generator.units) : "N/A" }
        }
    }
}
