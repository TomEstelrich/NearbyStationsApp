//
//  EVSEDataModelFactory.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

import CoreLocation

// MARK: EVSEDataModelFactory

struct EVSEDataModelFactory {

    static func build(from dataModelDTO: APIDataModelDTO) -> EVSEDataModel {
        let stations: [EVSEDataModel.Station] = dataModelDTO.features?.compactMap { feature in
            guard let coordinates = feature.geometry?.coordinates,
                  coordinates.count >= 2,
                  let longitude = coordinates.first,
                  let latitude = coordinates.last
            else {
                return nil
            }

            return EVSEDataModel.Station(
                id: feature.id,
                coordinates: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                status: (feature.properties?.evseStatus ?? .unknown).rawValue,
                phoneNumber: feature.properties?.phoneNumber,
                power: feature.properties?.chargingFacilities?.first?.power ?? 0,
                maxCapacity: feature.properties?.maxCapacity,
                renewableEnergy: feature.properties?.renewableEnergy == true ? "Yes" : "No"
            )
        } ?? []

        return EVSEDataModel(stations: stations, lastUpdate: dataModelDTO.timeStamp?.toDate())
    }
}
