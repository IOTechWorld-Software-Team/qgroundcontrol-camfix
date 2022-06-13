/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/


/// @file
///     @author Don Gagne <don@thegagnes.com>

#include "QGCPalette.h"
#include "QGCApplication.h"
#include "QGCCorePlugin.h"

#include <QApplication>
#include <QPalette>

QList<QGCPalette*>   QGCPalette::_paletteObjects;

QGCPalette::Theme QGCPalette::_theme = QGCPalette::Dark;

QMap<int, QMap<int, QMap<QString, QColor>>> QGCPalette::_colorInfoMap;

QStringList QGCPalette::_colors;

QGCPalette::QGCPalette(QObject* parent) :
    QObject(parent),
    _colorGroupEnabled(true)
{
    if (_colorInfoMap.isEmpty()) {
        _buildMap();
    }

    // We have to keep track of all QGCPalette objects in the system so we can signal theme change to all of them
    _paletteObjects += this;
}

QGCPalette::~QGCPalette()
{
    bool fSuccess = _paletteObjects.removeOne(this);
    if (!fSuccess) {
        qWarning() << "Internal error";
    }
}

void QGCPalette::_buildMap()
{
    //                                      Light                 Dark
    //                                      Disabled   Enabled    Disabled   Enabled
    DECLARE_QGC_COLOR(window,               "#737b80", "#fcfcfc", "#1a1e26", "#1a2933")
    DECLARE_QGC_COLOR(windowShadeLight,     "#babfbf", "#babfbf", "#5a6166", "#475a66")
    DECLARE_QGC_COLOR(windowShade,          "#d9d9d9", "#b1baba", "#383d40", "#2d3840")
    DECLARE_QGC_COLOR(windowShadeDark,      "#bdbdbd", "#8a9999", "#2d3033", "#242d33")
    DECLARE_QGC_COLOR(text,                 "#9d9d9d", "#000000", "#707580", "#ffffff")
    DECLARE_QGC_COLOR(warningText,          "#eb153d", "#eb153d", "#f85761", "#f85761")
    DECLARE_QGC_COLOR(button,               "#ffffff", "#86b9ba", "#707580", "#4d616e")
    DECLARE_QGC_COLOR(buttonText,           "#9d9d9d", "#000000", "#d8d8d8", "#cfe5e5")
    DECLARE_QGC_COLOR(buttonHighlight,      "#e4e4e4", "#00446d", "#3a3a3a", "#86b9ba")
    DECLARE_QGC_COLOR(buttonHighlightText,  "#2c2c2c", "#ffffff", "#2c2c2c", "#000000")
    DECLARE_QGC_COLOR(primaryButton,        "#585858", "#99baba", "#5a5e66", "#a8baba")
    DECLARE_QGC_COLOR(primaryButtonText,    "#2c2c2c", "#000000", "#2c2c2c", "#000000")
    DECLARE_QGC_COLOR(textField,            "#ffffff", "#ffffff", "#707580", "#ffffff")
    DECLARE_QGC_COLOR(textFieldText,        "#808080", "#000000", "#000000", "#000000")
    DECLARE_QGC_COLOR(mapButton,            "#585858", "#000000", "#585858", "#000000")
    DECLARE_QGC_COLOR(mapButtonHighlight,   "#585858", "#f58f51", "#585858", "#f58f51")
    DECLARE_QGC_COLOR(mapIndicator,         "#585858", "#cc7843", "#585858", "#f58f51")
    DECLARE_QGC_COLOR(mapIndicatorChild,    "#585858", "#a8826a", "#585858", "#bf703f")
    DECLARE_QGC_COLOR(colorGreen,           "#71b564", "#25b608", "#7bb66f", "#25b608")
    DECLARE_QGC_COLOR(colorOrange,          "#d9966c", "#f57425", "#f59765", "#f57425")
    DECLARE_QGC_COLOR(colorRed,             "#bf435a", "#eb153d", "#eb5775", "#eb153d")
    DECLARE_QGC_COLOR(colorGrey,            "#808080", "#808080", "#bfbfbf", "#bfbfbf")
    DECLARE_QGC_COLOR(colorBlue,            "#5990b3", "#0086d9", "#59aad9", "#0086d9")
    DECLARE_QGC_COLOR(alertBackground,      "#f58f51", "#f58f51", "#f5a97d", "#f58f51")
    DECLARE_QGC_COLOR(alertBorder,          "#737b80", "#737b80", "#808080", "#808080")
    DECLARE_QGC_COLOR(alertText,            "#000000", "#000000", "#000000", "#000000")
    DECLARE_QGC_COLOR(missionItemEditor,    "#585858", "#86b9ba", "#585858", "#86b9ba")
    DECLARE_QGC_COLOR(toolStripHoverColor,  "#585858", "#9D9D9D", "#585858", "#585d83")
    DECLARE_QGC_COLOR(statusFailedText,     "#9d9d9d", "#000000", "#707070", "#ffffff")
    DECLARE_QGC_COLOR(statusPassedText,     "#9d9d9d", "#000000", "#707070", "#ffffff")
    DECLARE_QGC_COLOR(statusPendingText,    "#9d9d9d", "#000000", "#707070", "#ffffff")
    DECLARE_QGC_COLOR(toolbarBackground,    "#abbaba", "#86b9ba", "#222222", "#141f26")

    // Colors not affecting by theming
    //                                              Disabled    Enabled
    DECLARE_QGC_NONTHEMED_COLOR(brandingPurple,     "#43006d", "#43006d")
    DECLARE_QGC_NONTHEMED_COLOR(brandingBlue,       "#00446d", "#31576e")
    DECLARE_QGC_NONTHEMED_COLOR(toolStripFGColor,   "#707070", "#ffffff")

    // Colors not affecting by theming or enable/disable
    DECLARE_QGC_SINGLE_COLOR(mapWidgetBorderLight,          "#ffffff")
    DECLARE_QGC_SINGLE_COLOR(mapWidgetBorderDark,           "#000000")
    DECLARE_QGC_SINGLE_COLOR(mapMissionTrajectory,          "#be781c")
    DECLARE_QGC_SINGLE_COLOR(surveyPolygonInterior,         "green")
    DECLARE_QGC_SINGLE_COLOR(surveyPolygonTerrainCollision, "red")
}

void QGCPalette::setColorGroupEnabled(bool enabled)
{
    _colorGroupEnabled = enabled;
    emit paletteChanged();
}

void QGCPalette::setGlobalTheme(Theme newTheme)
{
    // Mobile build does not have themes
    if (_theme != newTheme) {
        _theme = newTheme;
        _signalPaletteChangeToAll();
    }
}

void QGCPalette::_signalPaletteChangeToAll()
{
    // Notify all objects of the new theme
    foreach (QGCPalette* palette, _paletteObjects) {
        palette->_signalPaletteChanged();
    }
}

void QGCPalette::_signalPaletteChanged()
{
    emit paletteChanged();
}
