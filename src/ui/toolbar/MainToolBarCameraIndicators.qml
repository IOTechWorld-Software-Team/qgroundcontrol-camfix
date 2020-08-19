import QtQuick                  2.4
import QtPositioning            5.2
import QtQuick.Layouts          1.2
import QtQuick.Controls         1.4
import QtQuick.Dialogs          1.2
import QtGraphicalEffects       1.0

import QGroundControl                   1.0
import QGroundControl.Controls          1.0
import QGroundControl.Controllers       1.0
import QGroundControl.FactSystem        1.0
import QGroundControl.FactControls      1.0
import QGroundControl.Palette           1.0
import QGroundControl.ScreenTools       1.0
import QGroundControl.Vehicle           1.0
import QGroundControl.MultiVehicleManager   1.0

Item {
    id: rootItem

    property var  _activeVehicle:   QGroundControl.multiVehicleManager.activeVehicle

    Row {
        id:                 rowContainer
        anchors.fill:       parent
        layoutDirection:    Qt.RightToLeft
        spacing:            ScreenTools.defaultFontPixelWidth * 5

        QGCColoredImage {
            id:                 timelapsIcon
            anchors.top:        parent.top
            anchors.bottom:     parent.bottom
            width:              height
            sourceSize.width:   width
            fillMode:           Image.PreserveAspectFit
            source:             "/qmlimages/camera_timelaps.svg"
            color:              qgcPal.text
            MouseArea {
                anchors.fill:   parent
                onClicked: {
                    if (_activeVehicle.multinnovCameraMode === "timelapse") {
                        _activeVehicle.multinnovCameraMode = "Unused"
                        timelapsIcon.color = qgcPal.text
                    } else {
                        _activeVehicle.multinnovCameraMode = "timelapse"
                        timelapsIcon.color = qgcPal.colorRed
                        videoIcon.color = qgcPal.text
                        photoIcon.color = qgcPal.text
                    }
                }
            }
        }

        QGCColoredImage {
            id:                 photoIcon
            anchors.top:        parent.top
            anchors.bottom:     parent.bottom
            width:              height
            sourceSize.width:   width
            fillMode:           Image.PreserveAspectFit
            source:             "/qmlimages/camera_photo2.svg"
            color:              qgcPal.text
            MouseArea {
                anchors.fill:   parent
                onClicked: {
                    if (_activeVehicle.multinnovCameraMode === "photo") {
                        _activeVehicle.multinnovCameraMode = "Unused"
                        photoIcon.color = qgcPal.text
                        timelapsIcon.color = qgcPal.text
                    } else {
                        _activeVehicle.multinnovCameraMode = "photo"
                        photoIcon.color = qgcPal.colorRed
                        videoIcon.color = qgcPal.text
                        timelapsIcon.color = qgcPal.text
                    }
                }
            }
        }

        QGCColoredImage {
            id:                 videoIcon    
            anchors.top:        parent.top
            anchors.bottom:     parent.bottom
            width:              height
            sourceSize.width:   width
            fillMode:           Image.PreserveAspectFit
            source:             "/qmlimages/camera_video.svg"
            color:              qgcPal.text
            MouseArea {
                anchors.fill:   parent
                onClicked: {
                    if (_activeVehicle.multinnovCameraMode === "video") {
                        _activeVehicle.multinnovCameraMode = "Unused"
                        videoIcon.color = qgcPal.text
                    } else {
                        _activeVehicle.multinnovCameraMode = "video"
                        videoIcon.color = qgcPal.colorRed
                        timelapsIcon.color = qgcPal.text
                        photoIcon.color = qgcPal.text
                    }
                }
            }
            
        }
    }        
}