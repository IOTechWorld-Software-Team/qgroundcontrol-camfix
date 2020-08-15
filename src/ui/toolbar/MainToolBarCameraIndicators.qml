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

Item{
    id: rootItem

    Row {
        id:                 rowContainer
        anchors.fill:       parent
        layoutDirection:    Qt.RightToLeft
        spacing:            ScreenTools.defaultFontPixelWidth * 5

        QGCColoredImage {
            anchors.top:        parent.top
            anchors.bottom:     parent.bottom
            width:              height
            sourceSize.width:   width
            fillMode:           Image.PreserveAspectFit
            source:             "/qmlimages/camera_timelaps.svg"
            color:              qgcPal.text//_cameraTimeLapsMode ? qgcPal.colorRed : qgcPal.text
            /*MouseArea {
                anchors.fill:   parent
                enabled:        _cameraPhotoMode
                onClicked: {
                }
            }*/
        }

        QGCColoredImage {
            anchors.top:        parent.top
            anchors.bottom:     parent.bottom
            width:              height
            sourceSize.width:   width
            fillMode:           Image.PreserveAspectFit
            source:             "/qmlimages/camera_photo2.svg"
            color:              qgcPal.text//_cameraPhotoMode ? qgcPal.colorRed : qgcPal.text
            /*MouseArea {
                anchors.fill:   parent
                enabled:        _cameraPhotoMode
                onClicked: {
                }
            }*/
        }

        QGCColoredImage {
            anchors.top:        parent.top
            anchors.bottom:     parent.bottom
            width:              height
            sourceSize.width:   width
            fillMode:           Image.PreserveAspectFit
            source:             "/qmlimages/camera_video.svg"
            color:              qgcPal.text//_cameraVideoMode ? qgcPal.colorRed : qgcPal.text
            /*MouseArea {
                anchors.fill:   parent
                enabled:        _cameraPhotoMode
                onClicked: {
                }
            }*/
        }
    }        
}