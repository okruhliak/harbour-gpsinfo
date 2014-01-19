import QtQuick 2.0
import Sailfish.Silica 1.0
import QtPositioning 5.0
import QtSensors 5.0

import "../LocationFormatter.js" as LocationFormater

Page {
    id: page
    property PositionSource positionSource
    property Compass compass
    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: "about"
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: "settings"
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
            MenuItem {
                text: positionSource.active ? "deactivate GPS" : "activate GPS"
                onClicked: {
                    if (positionSource.active) {
                        console.log("deactivating GPS");
                        positionSource.stop();
                        console.log("active: " + positionSource.active);
                    } else {
                        console.log("activating GPS");
                        positionSource.start();
                        console.log("active: " + positionSource.active);
                    }
                }
            }
        }

        contentHeight: column.height

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: "GPS Info"
            }
            InfoField {
                label: "GPS"
                visible: settings.showGpsStateApp
                value: positionSource.active ? "active" : "inactive"
            }
            InfoField {
                label: "Latitude"
                visible: settings.showLatitudeApp
                value: {
                    if (positionSource.position.latitudeValid) {
                        if (settings.value("coordinateFormat") === "DEG") {
                            return LocationFormater.decimalLatToDMS(positionSource.position.coordinate.latitude, 2)
                        } else {
                            return positionSource.position.coordinate.latitude
                        }
                    }
                    return "-"
                }
            }
            InfoField {
                label: "Longitude"
                visible: settings.showLongitudeApp
                value: {
                    if (positionSource.position.longitudeValid) {
                        if (settings.value("coordinateFormat") === "DEG") {
                            return LocationFormater.decimalLongToDMS(positionSource.position.coordinate.longitude, 2)
                        } else {
                            return positionSource.position.coordinate.longitude
                        }
                    }
                    return "-"
                }
            }
            InfoField {
                label: "Altitude"
                visible: settings.showAltitudeApp
                value: {
                    if (positionSource.position.altitudeValid) {
                        if (settings.value("units") == "MET") {
                            return positionSource.position.coordinate.altitude + " m"
                        } else {
                            return LocationFormater.roundToDecimal(positionSource.position.coordinate.altitude * 3.2808399, 2) + " ft"
                        }
                    }
                    return "-"
                }
            }
            InfoField {
                label: "Current speed"
                visible: settings.showSpeedApp
                value: {
                    if (positionSource.position.speedValid) {
                        if (settings.value("units") == "MET") {
                            return positionSource.position.speed + " m/s"
                        } else {
                            return LocationFormater.roundToDecimal(positionSource.position.speed * 3.2808399, 2) + " ft/s"
                        }
                    }
                    return "-"
                }
            }
            InfoField {
                label: "Last update"
                visible: settings.showLastUpdateApp
                value: Qt.formatTime(positionSource.position.timestamp, "hh:mm:ss")
            }
            InfoField {
                label: "Vertical accuracy"
                visible: settings.showVerticalAccuracyApp
                value: {
                    if (positionSource.position.verticalAccuracyValid) {
                        if (settings.value("units") == "MET") {
                            return positionSource.position.verticalAccuracy + " m"
                        } else {
                            return LocationFormater.roundToDecimal(positionSource.position.verticalAccuracy * 3.2808399, 2) + " ft"
                        }
                    }
                    return "-"
                }
            }
            InfoField {
                label: "Horizontal accuracy"
                visible: settings.showHorizontalAccuracyApp
                value: {
                    if (positionSource.position.horizontalAccuracyValid) {
                        if (settings.value("units") == "MET") {
                            return positionSource.position.horizontalAccuracy + " m"
                        } else {
                            return LocationFormater.roundToDecimal(positionSource.position.horizontalAccuracy * 3.2808399, 2) + " ft"
                        }
                    }
                    return "-"
                }
            }
            InfoField {
                label: "Compass direction"
                visible: settings.showCompassDirectionApp
                value: LocationFormater.formatDirection(compass.reading.azimuth)
            }
        }
    }
}


