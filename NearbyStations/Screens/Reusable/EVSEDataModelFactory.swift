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
        let chargingStations: [EVSEDataModel.ChargingStation] = dataModelDTO.features?.compactMap { feature in
            guard let coordinates = feature.geometry?.coordinates,
                  coordinates.count >= 2,
                  let latitude = coordinates.first,
                  let longitude = coordinates.last
            else {
                return nil
            }

            return EVSEDataModel.ChargingStation(
                id: feature.id,
                coordinates: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                status: (feature.properties?.evseStatus ?? .unknown).rawValue,
                phoneNumber: feature.properties?.phoneNumber,
                power: feature.properties?.chargingFacilities?.first?.power ?? 0,
                maxCapacity: feature.properties?.maxCapacity,
                renewableEnergy: feature.properties?.renewableEnergy
            )
        } ?? []

        return EVSEDataModel(chargingStations: chargingStations, lastUpdate: dataModelDTO.timeStamp?.toDate())
    }
}
