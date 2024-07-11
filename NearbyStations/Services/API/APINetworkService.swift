//
//  APINetworkService.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

import Foundation

// MARK: APINetworkService

final class APINetworkService: Sendable {

    func fetchStations(latitude: Double, longitude: Double, distanceKm: Double = 2) async throws -> APIDataModelDTO {
        let boundingBox = EVSEDataModelHelper.calculateBoundingBox(latitude: latitude, longitude: longitude, distanceKm: distanceKm)
        let cqlFilter = "&cql_filter=bbox(geometry,\(boundingBox.minLongitude),\(boundingBox.minLatitude),\(boundingBox.maxLongitude),\(boundingBox.maxLatitude))"

        guard let url = URL(string: APINetworkURL.baseURL + cqlFilter) else {
            throw APINetworkError.invalidURL
        }

        var data: Data

        do {
            let (fetchedData, _) = try await URLSession.shared.data(from: url)
            data = fetchedData
        } catch {
            throw APINetworkError.networkError(error)
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(APIDataModelDTO.self, from: data)
        } catch {
            throw APINetworkError.decodingError(error)
        }
    }

    func isCoordinateInsideBoundingBox(latitude: Double, longitude: Double, boundingBox: BoundingBox) -> Bool {
        EVSEDataModelHelper.isCoordinateInsideBoundingBox(latitude: latitude, longitude: longitude, boundingBox: boundingBox)
    }
}
