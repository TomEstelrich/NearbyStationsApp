//
//  EVSEDataModelHelper.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

import CoreLocation

// MARK: EVSEDataModelHelper

struct EVSEDataModelHelper {

    static func calculateBoundingBox(latitude: Double, longitude: Double, distanceKm: Double) -> BoundingBox {
        let earthRadiusKm: Double = 6378.1

        let deltaLatitude = distanceKm / earthRadiusKm
        let deltaLongitude = distanceKm / (earthRadiusKm * cos(latitude * .pi / 180))

        let minLatitude = latitude - deltaLatitude * (180 / .pi)
        let maxLatitude = latitude + deltaLatitude * (180 / .pi)
        let minLongitude = longitude - deltaLongitude * (180 / .pi)
        let maxLongitude = longitude + deltaLongitude * (180 / .pi)

        return BoundingBox(minLongitude: minLongitude, minLatitude: minLatitude, maxLongitude: maxLongitude, maxLatitude: maxLatitude)
    }

    static func isCoordinateInsideBoundingBox(latitude: Double, longitude: Double, boundingBox: BoundingBox) -> Bool {
        latitude >= boundingBox.minLatitude &&
        latitude <= boundingBox.maxLatitude &&
        longitude >= boundingBox.minLongitude &&
        longitude <= boundingBox.maxLongitude
    }
}
