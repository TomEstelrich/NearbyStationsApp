//
//  EVSEDataModel.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

import CoreLocation

// MARK: EVSEDataModel

struct EVSEDataModel: Identifiable, Codable {

    var id: UUID = UUID()
    var stations: [Station] = []
    var lastUpdate: Date?

    /// Station
    struct Station: Identifiable, Codable {

        let id: String
        let coordinates: CLLocationCoordinate2D
        let status: String
        let phoneNumber: String?
        let power: Double?
        let maxCapacity: Int?
        let renewableEnergy: String?

    }
}
