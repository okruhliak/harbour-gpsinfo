import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "components"

ApplicationWindow
{
    LocationFormatter {
        id: locationFormatter
    }

    Providers {
        id: providers
    }
    initialPage: Component {
        SatelliteBarchartPage {
            positionSource: providers.positionSource
            compass: providers.compass
            gpsDataSource: providers.gpsDataSource
        }
    }
    cover: CoverPage {
        positionSource: providers.positionSource
        compass: providers.compass
        gpsDataSource: providers.gpsDataSource
    }
}
