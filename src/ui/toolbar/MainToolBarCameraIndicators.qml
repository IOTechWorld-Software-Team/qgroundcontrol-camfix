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

Item {
    id: rootItem

    property bool _cameraVideoMode: false
    property bool _cameraPhotoMode: false
    property bool _cameraTimeLapsMode: false

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
            color:              _cameraTimeLapsMode ? qgcPal.colorRed : qgcPal.text
            MouseArea {
                anchors.fill:   parent
                onClicked: {
                    if (_cameraTimeLapsMode) {
                        _cameraTimeLapsMode = false
                    } else {
                        _cameraTimeLapsMode = true
                        _cameraPhotoMode = false
                        _cameraVideoMode = false
                    }
                }
            }
        }

        QGCColoredImage {
            anchors.top:        parent.top
            anchors.bottom:     parent.bottom
            width:              height
            sourceSize.width:   width
            fillMode:           Image.PreserveAspectFit
            source:             "/qmlimages/camera_photo2.svg"
            color:              _cameraPhotoMode ? qgcPal.colorRed : qgcPal.text
            MouseArea {
                anchors.fill:   parent
                onClicked: {
                    if (_cameraPhotoMode) {
                        _cameraPhotoMode = false
                    } else {
                        _cameraPhotoMode = true
                        _cameraVideoMode = false
                        _cameraTimeLapsMode = false
                        
                    }
                }
            }
        }

        QGCColoredImage {
            anchors.top:        parent.top
            anchors.bottom:     parent.bottom
            width:              height
            sourceSize.width:   width
            fillMode:           Image.PreserveAspectFit
            source:             "/qmlimages/camera_video.svg"
            color:              _cameraVideoMode ? qgcPal.colorRed : qgcPal.text
            MouseArea {
                anchors.fill:   parent
                onClicked: {
                    if (_cameraVideoMode) {
                        _cameraVideoMode = false
                    } else {
                        _cameraVideoMode = true
                        _cameraPhotoMode = false
                        _cameraTimeLapsMode = false
                    }
                }
            }
            
        }
    }        
}