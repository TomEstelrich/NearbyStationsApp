//
//  APINetworkError.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

// MARK: APINetworkError

enum APINetworkError: Error {

    case invalidURL
    case networkError(Error)
    case decodingError(Error)

}
