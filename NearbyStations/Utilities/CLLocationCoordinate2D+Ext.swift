//
//  CLLocationCoordinate2D+Ext.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

import CoreLocation

// MARK: Locations

extension CLLocationCoordinate2D {

    static let zurich = CLLocationCoordinate2D(latitude: 47.3769, longitude: 8.5417)

}

// MARK: Codable

extension CLLocationCoordinate2D: Codable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}
