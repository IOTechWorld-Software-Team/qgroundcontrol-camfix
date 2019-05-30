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
    height: 150
    width: 350

    // Prevent all clicks from going through to lower layers
    DeadMouseArea {
        anchors.fill: parent
    }  

    Rectangle {

        id: qhrectangle
        anchors.fill: parent
        color: Qt.darker("grey",5.0)
        radius: 1

        GridLayout {
            id:                 qhinstrumentsgrid
            columnSpacing:      ScreenTools.defaultFontPixelWidth
            columns:            3
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5

            QGCLabel { 
                Layout.column: 1
                Layout.row: 1
                text: qsTr("Voltage:") 
            }

            QGCLabel { 
                Layout.column: 2
                Layout.row: 1
                text: (_activeVehicle && _activeVehicle.battery.voltage.value != -1) ? (_activeVehicle.battery.voltage.valueString + " " + _activeVehicle.battery.voltage.units) : "N/A" 
            }

            QGCLabel { 
                Layout.column: 1
                Layout.row: 2
                text: qsTr("Current:") 
            }

            /*-------------TEST-----------
            ProgressBar {
                id: progressbarcurrent

                //Position parameters
                Layout.column: 2
                Layout.row: 2
                Layout.preferredHeight: 10
                Layout.preferredWidth: 125
                
                //Values and conditions
                maximumValue: 70    //Max current ever recorded in a peak was 55A
                indeterminate: (_activeVehicle && _activeVehicle.battery.current.value !== -1) ? false : true
                value: (_activeVehicle && _activeVehicle.battery.current.value !== -1) ? _activeVehicle.battery.current.value : 0

                style: ProgressBarStyle{
                    background: Rectangle {
                        radius: 1
                        color: "lightgrey"
                        implicitWidth: parent.Layout.preferredWidth
                        implicitHeight: parent.Layout.preferredHeight
                    }
                    progress: Rectangle {
                        color: "green"
                        border.color: "darkred"
                    }
                }
            }
            ------------TEST----------*/

            
            QHProgressBar {
                
                id: progressbarcurrent

                Layout.column: 2
                Layout.row: 2

                //Values and conditions
                maximumValue: 70    //Max current ever recorded in a peak was 55A
                indeterminate: (_activeVehicle && _activeVehicle.battery.current.value !== -1) ? false : true
                value: (_activeVehicle && _activeVehicle.battery.current.value !== -1) ? _activeVehicle.battery.current.value : 0

                style: ProgressBarStyle{
                    progress: Rectangle {
                        color: "green"
                        border.color: "darkred"
                    }
                }

            }
            


            QGCLabel { 
                Layout.column: 3
                Layout.row: 2
                text: (_activeVehicle && _activeVehicle.battery.current.value != -1) ? (_activeVehicle.battery.current.valueString + " " + _activeVehicle.battery.current.units) : "N/A"
             }
            
            QGCLabel { 
                Layout.column: 1
                Layout.row: 3
                text: qsTr("Current generator:") 
            }

           
            ProgressBar {
                id: progressbargenerator

                //Position parameters
                Layout.column: 2
                Layout.row: 3
                Layout.preferredHeight: 10
                Layout.preferredWidth: 125
                
                //Values and conditions
                maximumValue: 70    //Max current the generator produces is 50A
                indeterminate: (_activeVehicle && _activeVehicle.battery.current_generator.value !== -1) ? false : true
                value: (_activeVehicle && _activeVehicle.battery.current_generator.value !== -1) ? _activeVehicle.battery.current_generator.value : 0

                style: ProgressBarStyle{
                    background: Rectangle {
                        radius: 1
                        color: "lightgrey"
                        implicitWidth: parent.Layout.preferredWidth
                        implicitHeight: parent.Layout.preferredHeight
                    }
                    progress: Rectangle {
                        color: "red"
                        border.color: "darkred"
                    }
                }
            }

            QGCLabel { 
                Layout.column: 3
                Layout.row: 3
                text: (_activeVehicle && _activeVehicle.battery.current_generator.value != -1) ? (_activeVehicle.battery.current_generator.valueString + " " + _activeVehicle.battery.current_generator.units) : "N/A"
             }

            
            QGCLabel { 
                Layout.column: 1
                Layout.row: 5
                text: qsTr("Current rotor:")
            }

            ProgressBar {
                id: progressbarrotor

                //Position parameters
                Layout.column: 2
                Layout.row: 5
                Layout.preferredHeight: 10
                Layout.preferredWidth: 125
                
                //Values and conditions
                minimumValue: -15   //Current provided by governor to batteries is limited to 15A
                maximumValue: 15    //Current provided by governor to batteries is limited to 15A
                indeterminate: (_activeVehicle && _activeVehicle.battery.current_rotor.value !== -1) ? false : true
                value: (_activeVehicle && _activeVehicle && _activeVehicle.battery.current_rotor.value !== -1) ? _activeVehicle.battery.current_rotor.value : 0

                style: ProgressBarStyle{
                    background: Rectangle {
                        radius: 1
                        color: "lightgrey"
                        implicitWidth: parent.Layout.preferredWidth
                        implicitHeight: parent.Layout.preferredHeight
                    }
                    progress: Rectangle {
                        color: "orange"
                        border.color: "green"
                    }
                }
            }

            QGCLabel { 
                Layout.column: 3
                Layout.row: 5
                text: (_activeVehicle && _activeVehicle.battery.current_rotor.value != -1) ? (_activeVehicle.battery.current_rotor.valueString + " " + _activeVehicle.battery.current_rotor.units) : "N/A" 
            }

            QGCLabel { 
                Layout.column: 1
                Layout.row: 6
                text: qsTr("Fuel level:") 
            }

            ProgressBar {
                id: progressbarfuel

                //Position parameters
                Layout.column: 2
                Layout.row: 6
                Layout.preferredHeight: 10
                Layout.preferredWidth: 125
                
                //Values and conditions
                maximumValue: 5000  //Max capacity of the fuel tank is 5000ml
                indeterminate: (_activeVehicle && _activeVehicle.battery.fuel_level.value !== -1) ? false : true
                value: (_activeVehicle && _activeVehicle && _activeVehicle.battery.fuel_level.value !== -1) ? _activeVehicle.battery.fuel_level.value : 0

                style: ProgressBarStyle{
                    background: Rectangle {
                        radius: 1
                        color: "lightgrey"
                        implicitWidth: parent.Layout.preferredWidth
                        implicitHeight: parent.Layout.preferredHeight
                    }
                    progress: Rectangle {
                        color: "orange"
                        border.color: "green"
                    }
                }
            }
            
            QGCLabel { 
                Layout.column: 3
                Layout.row: 6
                text: (_activeVehicle && _activeVehicle.battery.fuel_level.value != -1) ? (_activeVehicle.battery.fuel_level.valueString + " " + _activeVehicle.battery.fuel_level.units) : "N/A" 
            }

            QGCLabel { 
                Layout.column: 1
                Layout.row: 7
                text: qsTr("Throttle percentage:") 
            }

            ProgressBar {
                id: progressbarthrottle

                //Position parameters
                Layout.column: 2
                Layout.row: 7
                Layout.preferredHeight: 10
                Layout.preferredWidth: 125
                
                //Values and conditions
                maximumValue: 2000
                indeterminate: (_activeVehicle && _activeVehicle.battery.throttle_percentage.value !== -1) ? false : true
                value: (_activeVehicle && _activeVehicle && _activeVehicle.battery.throttle_percentage.value !== -1) ? _activeVehicle.battery.throttle_percentage.value : 0

                style: ProgressBarStyle{
                    background: Rectangle {
                        radius: 1
                        color: "lightgrey"
                        implicitWidth: parent.Layout.preferredWidth
                        implicitHeight: parent.Layout.preferredHeight
                    }
                    progress: Rectangle {
                        color: "orchid"
                        border.color: "yellow"
                    }
                }
            }
            
            QGCLabel { 
                Layout.column: 3
                Layout.row: 7
                text: (_activeVehicle && _activeVehicle.battery.throttle_percentage.value != -1) ? (_activeVehicle.battery.throttle_percentage.valueString + " " + _activeVehicle.battery.throttle_percentage.units) : "N/A" 
            }
        }
    }
}
