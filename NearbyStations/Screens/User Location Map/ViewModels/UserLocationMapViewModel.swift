//
//  UserLocationMapViewModel.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

import MapKit
import SwiftUI

// MARK: UserLocationMapViewModel

@MainActor @Observable final class UserLocationMapViewModel: NSObject, CLLocationManagerDelegate, Sendable {

    // MARK: Internal

    var position: MapCameraPosition = .userLocation(
        followsHeading: true,
        fallback: .camera(
            MapCamera(centerCoordinate: .zurich, distance: 10000)
        )
    )

    var dataModel: EVSEDataModel = EVSEDataModel()

    func fetchChargingStations(latitude: Double?, longitude: Double?) async {
        guard let latitude, let longitude else { return }

        do {
            let dataModelDTO = try await APINetworkService.fetchChargingStations(latitude: latitude, longitude: longitude)
            dataModel = EVSEDataModelFactory.build(from: dataModelDTO)
            try fileManagerService.save(dataModel)
            print(dataModel.chargingStations.count)

            dataModel.chargingStations.forEach { print($0.coordinates) }
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: Private

    var locationService = LocationService()
    var fileManagerService = FileManagerService()

}
